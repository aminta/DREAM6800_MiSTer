// DREAM 6800 (M.J. Bauer, Electronics Australia 1979) - the machine.
// See docs/SPEC.md.  CPU = cpu68 (J.E. Kent), PIA = pia6821 (J.E. Kent).
//
// Clocking: everything runs on clk.  ce_cpu = 1 MHz (6800 E clock), ce_dot = 2 MHz
// (video dot clock), both derived here: CPU_DIV clocks per CPU cycle (even, >= 4).
// cpu68 advances on the falling edge of clk when hold = 0, so ce_cpu acts as its
// clock enable (hold = ~ce_cpu), as in the Williams sound boards.

module dream6800 #(
    parameter int CPU_DIV = 40            // clk / 1 MHz  (40 MHz on MiSTer)
) (
    input  logic        clk,
    input  logic        reset,            // RST key or core reset (active high)

    // options
    input  logic [1:0]  ram_size,         // 0 = 1K, 1 = 2K, 2/3 = 4K
    input  logic        turbo,            // 1 = no DMA halt (CPU at full 1 MHz)
    input  logic [7:0]  joy_x,            // Bauer joystick position, 0 = left / top
    input  logic [7:0]  joy_y,

    // keypad: key[n] = hex key n down; fn = FN key down
    input  logic [15:0] key,
    input  logic        fn,

    // video (dot clock domain enables)
    output logic        ce_dot,
    output logic        pix,              // 1 = white dot
    output logic        hsync,            // active high
    output logic        vsync,            // active high
    output logic        hblank,
    output logic        vblank,
    output logic [6:0]  hcount,           // 0..127 dots
    output logic [8:0]  vcount,           // 0..311 lines
    output logic        dma_on,           // CB2 (display enabled)

    // sound / tape
    output logic        speaker,          // square wave to the speaker
    output logic        speaker_en,       // speaker switched on (PB6 and DMA on)
    output logic        tape_out,         // square wave to the cassette (always running)
    input  logic        tape_in,          // comparator output from the cassette (1 = high)

    // loader / debug port (CPU must be in reset while writing)
    input  logic        dl_we,
    input  logic        dl_rom,           // 1 = write CHIPOS ROM, 0 = write RAM
    input  logic [11:0] dl_addr,
    input  logic [7:0]  dl_data,
    input  logic        boot_ovr,         // 1 = next reset vector fetch returns boot_addr
    input  logic [15:0] boot_addr,

    // debug
    output logic [15:0] dbg_addr,
    output logic        dbg_vma,
    output logic        dbg_rw,
    output logic        dbg_ce,
    output logic [7:0]  dbg_dout,
    output logic [7:0]  dbg_din,
    output logic        dbg_halted,
    input  logic [11:0] dbg_raddr,        // RAM peek (simulation / debug)
    output logic [7:0]  dbg_rdata
);

    // ------------------------------------------------------------------ clocks
    localparam int DOT_DIV = CPU_DIV / 2;
    logic [$clog2(CPU_DIV)-1:0] cdiv;
    logic ce_cpu;
    always_ff @(posedge clk) begin
        cdiv   <= (cdiv == CPU_DIV-1) ? '0 : cdiv + 1'd1;
    end
    assign ce_cpu = (cdiv == CPU_DIV-1);
    assign ce_dot = (cdiv == CPU_DIV-1) || (cdiv == DOT_DIV-1);

    // ------------------------------------------------------------------ CPU
    logic [15:0] addr;
    logic [7:0]  cpu_dout, cpu_din;
    logic        rw, vma, irq, halt;

    cpu68 cpu (
        .clk(clk), .rst(reset), .rw(rw), .vma(vma), .address(addr),
        .data_in(cpu_din), .data_out(cpu_dout),
        .hold(~ce_cpu), .halt(halt), .irq(irq), .nmi(1'b0),
        .test_alu(), .test_cc()
    );

    // address decoding (partial, as on the board; see SPEC 2)
    wire sel_ram = ~addr[15];
    wire sel_pia = addr[15] & ~addr[14];
    wire sel_rom = addr[15] &  addr[14];

    // ------------------------------------------------------------------ memory
    logic [7:0] rom [0:1023];
    logic [7:0] ram [0:4095];
    logic [7:0] rom_q, ram_q;

    wire [11:0] ram_a = ram_size == 2'd0 ? {2'b00, addr[9:0]} :
                        ram_size == 2'd1 ? {1'b0, addr[10:0]} : addr[11:0];

    // RAM port A: CPU read/write, or loader write (CPU held off while loading).
    // RAM port B: video read only.  ROM: one port, loader write or CPU read.
    wire        cpu_we = ce_cpu & vma & ~rw & sel_ram;
    wire [11:0] ram_pa = dl_we ? dl_addr : ram_a;
    wire        ram_we = (dl_we & ~dl_rom) | cpu_we;
    wire [7:0]  ram_d  = dl_we ? dl_data : cpu_dout;
    wire [9:0]  rom_pa = (dl_we & dl_rom) ? dl_addr[9:0] : addr[9:0];

    always_ff @(posedge clk) begin
        if (ram_we) ram[ram_pa] <= ram_d;
        ram_q <= ram[ram_pa];
    end
    always_ff @(posedge clk) begin
        if (dl_we & dl_rom) rom[rom_pa] <= dl_data;
        rom_q <= rom[rom_pa];
    end

    // boot vector override (quick load): the reset sequence reads FFFE, FFFF
    logic ovr;
    always_ff @(posedge clk) begin
        if (boot_ovr && reset) ovr <= 1'b1;
        else if (ce_cpu && vma && rw && addr == 16'hFFFF) ovr <= 1'b0;
    end

    // ------------------------------------------------------------------ PIA
    logic [7:0] pia_q, pa_i, pa_o, pa_oe, pb_i, pb_o, pb_oe;
    logic       ca1, ca2, cb1, cb2_o, cb2_oe, irqa, irqb;

    pia6821 pia (
        .clk(clk), .rst(reset),
        .cs(ce_cpu & vma & sel_pia), .rw(rw), .addr(addr[1:0]),
        .data_in(cpu_dout), .data_out(pia_q), .irqa(irqa), .irqb(irqb),
        .pa_i(pa_i), .pa_o(pa_o), .pa_oe(pa_oe), .ca1(ca1), .ca2_i(ca2),
        .ca2_o(), .ca2_oe(),
        .pb_i(pb_i), .pb_o(pb_o), .pb_oe(pb_oe), .cb1(cb1), .cb2_i(1'b0),
        .cb2_o(cb2_o), .cb2_oe(cb2_oe)
    );
    assign irq = irqa | irqb;

    always_comb begin
        if (sel_rom) begin
            if (ovr && addr == 16'hFFFE)      cpu_din = boot_addr[15:8];
            else if (ovr && addr == 16'hFFFF) cpu_din = boot_addr[7:0];
            else                              cpu_din = rom_q;
        end
        else if (sel_pia) cpu_din = pia_q;
        else              cpu_din = ram_q;
    end

    // ------------------------------------------------------------------ keypad
    // Rows PA4-PA7, columns PA0-PA3; key code = row*4 + col.  A line that the
    // PIA drives is at the driven level; an input line is pulled up and goes
    // low through a closed key to a line driven low.
    logic [3:0] row_lvl, col_lvl;
    always_comb begin
        for (int r = 0; r < 4; r++) begin
            logic low;
            low = 1'b0;
            for (int c = 0; c < 4; c++)
                if (key[r*4+c] && pa_oe[c] && !pa_o[c]) low = 1'b1;
            row_lvl[r] = pa_oe[4+r] ? pa_o[4+r] : ~low;
        end
        for (int c = 0; c < 4; c++) begin
            logic low;
            low = 1'b0;
            for (int r = 0; r < 4; r++)
                if (key[r*4+c] && pa_oe[4+r] && !pa_o[4+r]) low = 1'b1;
            col_lvl[c] = pa_oe[c] ? pa_o[c] : ~low;
        end
    end
    assign pa_i = {row_lvl, col_lvl};
    assign ca1  = ~&col_lvl;              // any column low -> CA1 high
    assign ca2  = ~fn;                    // FN: falling edge on CA2

    // ------------------------------------------------------------------ video
    // 128 dots x 312 lines at 2 MHz; picture = dots 0-63 of lines 0-127
    // (dot rows 0-31, 4 lines each).  HSYNC dots 88-95, VSYNC from dot row 56
    // for ~300 us (5 lines).  Lines 0-127 halt the CPU (VERT-EN) when DMA is on.
    logic [6:0] h;
    logic [8:0] v;
    always_ff @(posedge clk) if (ce_dot) begin
        h <= h + 1'd1;
        if (h == 7'd127) v <= (v == 9'd311) ? 9'd0 : v + 1'd1;
    end
    assign hcount = h;
    assign vcount = v;

    assign dma_on  = cb2_oe & cb2_o;
    wire   vert_en = (v < 9'd128) & dma_on;
    assign halt    = vert_en & ~turbo;

    // video RAM read (second port); byte for dot h is fetched one dot ahead
    wire [6:0] hn = h + 1'd1;
    wire [8:0] vn = (h != 7'd127) ? v : (v == 9'd311) ? 9'd0 : v + 1'd1;
    logic [7:0] vbyte, shreg;
    always_ff @(posedge clk) vbyte <= ram[{4'b0001, vn[6:2], hn[5:3]}];
    always_ff @(posedge clk) if (ce_dot) begin
        if (hn[2:0] == 3'd0) shreg <= vbyte;     // load at the start of each byte
        else                 shreg <= {shreg[6:0], 1'b0};
    end
    // pix belongs to dot h (registered stage above makes shreg valid for h)
    assign pix    = shreg[7] & ~hblank & ~vblank & dma_on;
    assign hblank = h[6];                       // dots 64-127
    assign vblank = (v >= 9'd128);
    assign hsync  = (h >= 7'd88) && (h < 7'd96);
    assign vsync  = (v >= 9'd224) && (v < 9'd229);
    assign cb1    = vsync;                      // RTC interrupt [STIMA]: VSYNC rising edge

    // ------------------------------------------------------------------ sound
    // NE556: 2400 Hz when PB0 = 1, 1200 Hz when PB0 = 0.  Speaker = PB6 and DMA on.
    logic [8:0] ne_cnt;       // counts CPU-clock microseconds
    logic       ne_out;
    always_ff @(posedge clk) if (ce_cpu) begin
        if (ne_cnt == 9'd0) begin
            ne_out <= ~ne_out;
            ne_cnt <= pb_o[0] ? 9'd207 : 9'd415;   // half period 208 / 416 us
        end
        else ne_cnt <= ne_cnt - 1'd1;
    end
    assign tape_out = ne_out;
    assign speaker_en = pb_o[6] & dma_on;
    assign speaker    = ne_out & speaker_en;

    // ------------------------------------------------------------------ tape in
    // 74121 one-shot of 312 us triggered by a rising edge; when it times out a
    // flip-flop samples the input: still high = 1200 Hz (space, 0), low = 2400 Hz
    // (mark, 1).  PB7 = 1 for mark.
    // Before it, the input is rebuilt as a 50 % square (d6800_tape_square, 1.1 ms later):
    // the EA comparator gives a symmetric square already, but the MiSTer ADC
    // (ltc2308_tape) sees only the positive half-waves, so with a weak signal a 1200 Hz
    // cycle would be high for less than 312 us and read as 2400 Hz.
    logic       sq_d, tape_bit, tape_sq;
    logic [8:0] os_cnt;
    d6800_tape_square tsq (.clk(clk), .reset(reset), .ce_us(ce_cpu), .din(tape_in), .dout(tape_sq));
    always_ff @(posedge clk) begin
        if (reset) begin
            tape_bit <= 1'b1; os_cnt <= '0; sq_d <= 1'b0;
        end
        else if (ce_cpu) begin
            sq_d <= tape_sq;
            if (os_cnt != 0) begin
                os_cnt <= os_cnt - 1'd1;
                if (os_cnt == 9'd1) tape_bit <= ~tape_sq;
            end
            else if (tape_sq && !sq_d) os_cnt <= 9'd312;
        end
    end
    // ------------------------------------------------------------------ joystick
    // Bauer's joystick controller (DREAMER 3, 1980): a 4013 wired as two one-shots,
    // triggered together by a rising edge on PB5; pulse width set by the X and Y pots,
    // read back on PB1 (X) and PB2 (Y).  His routine counts up to 74 loops of ~33 us
    // while each output is high, minus 10: VC = 0..63, VD = 0..31.  Pulse here:
    // 264 us + 10 us per step of the position (0..255), i.e. ~0.26 to 2.8 ms.
    logic        pb5_d;
    logic [11:0] jx_cnt, jy_cnt;
    wire         pb5 = pb_oe[5] ? pb_o[5] : 1'b1;   // input: the 4013 clock is pulled up
    always_ff @(posedge clk) begin
        if (reset) begin
            pb5_d <= 1'b1; jx_cnt <= '0; jy_cnt <= '0;
        end
        else if (ce_cpu) begin
            pb5_d <= pb5;
            if (pb5 && !pb5_d) begin
                jx_cnt <= 12'd264 + {joy_x, 3'b0} + {3'b0, joy_x, 1'b0};
                jy_cnt <= 12'd264 + {joy_y, 3'b0} + {3'b0, joy_y, 1'b0};
            end
            else begin
                if (jx_cnt != 0) jx_cnt <= jx_cnt - 1'd1;
                if (jy_cnt != 0) jy_cnt <= jy_cnt - 1'd1;
            end
        end
    end

    assign pb_i = {tape_bit, 4'b0, jy_cnt != 0, jx_cnt != 0, 1'b0};

    // ------------------------------------------------------------------ debug
    assign dbg_addr   = addr;
    assign dbg_vma    = vma;
    assign dbg_rw     = rw;
    assign dbg_ce     = ce_cpu;
    assign dbg_dout   = cpu_dout;
    assign dbg_din    = cpu_din;
    assign dbg_halted = halt;
`ifdef VERILATOR
    assign dbg_rdata  = ram[dbg_raddr];
`else
    assign dbg_rdata  = 8'h00;
`endif

endmodule

// Tape input rebuilt as a symmetric square, duty-cycle independent: each cycle (rising
// edge to rising edge, up to 1050 us) is replayed DELAY us later as high for half its
// period, then low.  Longer gaps (silence, noise) give no output.
module d6800_tape_square #(parameter DELAY = 1100, MAXP = 1050) (
    input  logic clk,
    input  logic reset,
    input  logic ce_us,          // 1 MHz
    input  logic din,
    output logic dout
);
    logic [11:0] now;
    logic [10:0] per;                       // us since the last rising edge (saturating)
    logic        din_d;
    logic [11:0] rise_at [0:7], fall_at [0:7];
    logic [2:0]  wp, rp;
    wire         empty = wp == rp;
    wire  [11:0] r_new = now - 12'(per) + 12'(DELAY);
    always_ff @(posedge clk) begin
        if (reset) begin
            now <= 0; per <= 11'h7FF; din_d <= 0; wp <= 0; rp <= 0; dout <= 0;
        end
        else if (ce_us) begin
            now   <= now + 1'd1;
            din_d <= din;
            if (per != 11'h7FF) per <= per + 1'd1;
            if (din && !din_d) begin
                per <= 11'd1;
                if (per <= 11'(MAXP)) begin
                    rise_at[wp] <= r_new;
                    fall_at[wp] <= r_new + 12'(per >> 1);
                    wp <= wp + 1'd1;
                end
            end
            if (!empty) begin
                if (now == rise_at[rp]) dout <= 1'b1;
                if (now == fall_at[rp]) begin dout <= 1'b0; rp <= rp + 1'd1; end
            end
        end
    end
endmodule
