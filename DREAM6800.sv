//============================================================================
//  DREAM 6800 (Michael J. Bauer, Electronics Australia 1979) for MiSTer
//
//  rtl/dream6800.sv    the machine: 6800 + CHIPOS + PIA + DMA video + tape
//  rtl/d6800_input.sv  PC keyboard / joystick -> hex keypad, quick-load autotype
//  rtl/d6800_desk.sv   "Desk" view: the drawn machine, TV and recorder, mouse on the keys
//  rtl/cpu68.vhd       6800 CPU (John E. Kent), with a HALT fix (see its header)
//  rtl/pia6821.vhd     MC6821 PIA (John E. Kent)
//
//  This program is free software; you can redistribute it and/or modify it
//  under the terms of the GNU General Public License as published by the Free
//  Software Foundation; either version 2 of the License, or (at your option)
//  any later version.
//============================================================================

module emu
(
	`include "sys/emu_ports.vh"
);

assign USER_OUT = '1;
assign {UART_RTS, UART_TXD, UART_DTR} = 0;
assign {SD_SCK, SD_MOSI, SD_CS} = 'Z;
assign {SDRAM_DQ, SDRAM_A, SDRAM_BA, SDRAM_CLK, SDRAM_CKE, SDRAM_DQML, SDRAM_DQMH, SDRAM_nWE, SDRAM_nCAS, SDRAM_nRAS, SDRAM_nCS} = 'Z;
assign {DDRAM_CLK, DDRAM_BURSTCNT, DDRAM_ADDR, DDRAM_DIN, DDRAM_BE, DDRAM_RD, DDRAM_WE} = '0;

assign VGA_F1 = 0;
assign VGA_SCALER  = 0;
assign VGA_DISABLE = 0;
assign HDMI_FREEZE = 0;
assign HDMI_BLACKOUT = 0;
assign HDMI_BOB_DEINT = 0;
assign AUDIO_MIX = 0;
assign LED_POWER = 0;
assign BUTTONS = 0;

wire [1:0] ar    = status[122:121];
wire [2:0] scale = {1'b0, status[124:123]};

`include "build_id.v"
localparam CONF_STR = {
	"DREAM6800;;",
	"-;",
	"F1,C8 CH8BIND68,Load program;",
	"-;",
	"O[2:1],RAM,4K,2K,1K;",
	"O[3],Speed,Original,Turbo;",
	"O[5:4],Joystick,2 4 6 8 / 5,0 1 / 3,Bauer stick / F,Off;",
	"-;",
	"O[14],View,TV,Desk;",
	"O[7:6],Phosphor,White,Green,Amber;",
	"O[8],TV border,Full,Picture only;",
	"O[10:9],Scanlines,None,25%,50%,75%;",
	"O[122:121],Aspect ratio,Original,Full Screen,[ARC1],[ARC2];",
	"O[124:123],Scale,Normal,V-Integer,Narrower HV-Integer,Wider HV-Integer;",
	"-;",
	"O[12:11],Volume,High,Medium,Low,Off;",
	"O[13],Tape sound,Off,On;",
	"-;",
	"J1,Fire,FN,RST;",
	"jn,A,B,Select;",
	"R[0],Reset (RST);",
	"v,0;",
	"V,v",`BUILD_DATE
};

wire   [1:0] buttons;
wire [127:0] status;
wire  [10:0] ps2_key;
wire  [24:0] ps2_mouse;
wire  [31:0] joystick_0;
wire  [15:0] joy_a;
wire         forced_scandoubler;
wire  [21:0] gamma_bus;

wire         ioctl_download, ioctl_wr;
wire  [15:0] ioctl_index;
wire  [26:0] ioctl_addr;
wire   [7:0] ioctl_dout;
wire  [31:0] ioctl_file_ext;

hps_io #(.CONF_STR(CONF_STR)) hps_io
(
	.clk_sys(clk_sys),
	.HPS_BUS(HPS_BUS),
	.EXT_BUS(),
	.gamma_bus(gamma_bus),

	.buttons(buttons),
	.status(status),
	.status_menumask(16'd0),
	.forced_scandoubler(forced_scandoubler),

	.ps2_key(ps2_key),
	.ps2_mouse(ps2_mouse),
	.joystick_0(joystick_0),
	.joystick_l_analog_0(joy_a),

	.ioctl_download(ioctl_download),
	.ioctl_index(ioctl_index),
	.ioctl_wr(ioctl_wr),
	.ioctl_addr(ioctl_addr),
	.ioctl_dout(ioctl_dout),
	.ioctl_file_ext(ioctl_file_ext),
	.ioctl_wait(1'b0)
);

wire clk_sys;   // 40 MHz: CPU 1 MHz = /40, video dots 2 MHz = /20
pll pll
(
	.refclk(CLK_50M),
	.rst(0),
	.outclk_0(clk_sys)
);

// ---------------------------------------------------------------- loading
// index 0 = boot.rom: optional, replaces the built-in CHIPOS (loaded by the MiSTer at start-up)
// index 1 = program, written with the CPU held in RST; then CHIPOS starts normally
//           and the autotype keys in the run address and FN 3, like a user would:
//           .c8/.ch8  CHIP-8 from 0200, run C000
//           .bin      6800 machine code from 0200, run 0200
//           .d68      memory image: load address and run address (2 bytes each, high
//                     byte first), then the data (e.g. 0080-03FF programs of DREAMER)
wire load_rom  = ioctl_download && ioctl_index[5:0] == 6'd0;
wire load_prog = ioctl_download && ioctl_index[5:0] == 6'd1;
wire [23:0] ext      = ioctl_file_ext[23:0] | 24'h202020;
wire prog_bin  = ext == "bin";
wire prog_d68  = ext == "d68";                 // else CHIP-8 (.c8/.ch8)

reg  [7:0] hdr[4];                             // .d68 header
always @(posedge clk_sys) if (load_prog && prog_d68 && ioctl_wr && ioctl_addr < 27'd4) hdr[ioctl_addr[1:0]] <= ioctl_dout;
wire [15:0] d68_load = {hdr[0], hdr[1]};
wire [15:0] d68_run  = {hdr[2], hdr[3]};

reg  old_load_prog = 0, auto_start = 0;
reg  [15:0] auto_run;
always @(posedge clk_sys) begin
	old_load_prog <= load_prog;
	auto_start <= old_load_prog & ~load_prog;
	if (old_load_prog & ~load_prog) auto_run <= prog_d68 ? d68_run : prog_bin ? 16'h0200 : 16'hC000;
end

wire [15:0] d68_addr  = d68_load + ioctl_addr[15:0] - 16'd4;
wire [11:0] prog_addr = prog_d68 ? d68_addr[11:0] : 12'h200 + ioctl_addr[11:0];
wire        prog_ok   = prog_d68 ? (ioctl_addr >= 27'd4 && ioctl_addr < 27'h1004 && d68_addr < 16'h1000)
                                 : ioctl_addr < 27'hE00;
wire        dl_we     = ioctl_wr & (load_rom | (load_prog & prog_ok));

// ---------------------------------------------------------------- machine
wire [15:0] key;
wire  [7:0] stick_x, stick_y;
wire        fn, rst_key, auto_busy;
wire        ce_dot, pix, hs, vs, dma_on, speaker_en, tape_out, tape_adc, tape_adc_act;
wire  [6:0] hcount;
wire  [8:0] vcount;

wire desk = status[14];
wire [15:0] mkey;
wire        mfn, mrst, mshow;
wire  [9:0] mx, my;

wire reset = RESET | status[0] | buttons[1] | rst_key | mrst | ioctl_download;

d6800_input input_
(
	.clk(clk_sys),
	.reset(RESET),
	.ps2_key(ps2_key),
	.joy(joystick_0),
	.joy_a(joy_a),
	.joy_map(status[5:4]),
	.frame(ce_dot && hcount == 7'd127 && vcount == 9'd311),
	.auto_start(auto_start),
	.auto_run(auto_run),
	.key(key),
	.stick_x(stick_x),
	.stick_y(stick_y),
	.fn(fn),
	.rst(rst_key),
	.auto_busy(auto_busy)
);

dream6800 #(.CPU_DIV(40)) machine
(
	.clk(clk_sys),
	.reset(reset),
	.ram_size(status[2:1] == 2'd0 ? 2'd2 : status[2:1] == 2'd1 ? 2'd1 : 2'd0),
	.turbo(status[3]),
	.joy_x(stick_x),
	.joy_y(stick_y),
	.key(key | mkey),
	.fn(fn | mfn),
	.ce_dot(ce_dot),
	.pix(pix),
	.hsync(hs),
	.vsync(vs),
	.hblank(),
	.vblank(),
	.hcount(hcount),
	.vcount(vcount),
	.dma_on(dma_on),
	.speaker(),
	.speaker_en(speaker_en),
	.tape_out(tape_out),
	.tape_in(tape_adc),
	.dl_we(dl_we),
	.dl_rom(load_rom),
	.dl_addr(load_rom ? ioctl_addr[11:0] : prog_addr),
	.dl_data(ioctl_dout),
	.boot_ovr(1'b0),
	.boot_addr(16'h0000),
	.dbg_addr(), .dbg_vma(), .dbg_rw(), .dbg_ce(), .dbg_dout(), .dbg_din(), .dbg_halted(),
	.dbg_raddr(12'd0), .dbg_rdata()
);

// ---------------------------------------------------------------- tape in (ADC)
ltc2308_tape #(.CLK_RATE(40000000)) ltc2308_tape
(
	.reset(reset),
	.clk(clk_sys),
	.ADC_BUS(ADC_BUS),
	.dout(tape_adc),
	.active(tape_adc_act),
	.adc_sync(),
	.adc_data()
);

// ---------------------------------------------------------------- audio
// The speaker and the tape output come from the same NE556.
reg [15:0] snd;
always @(posedge clk_sys) begin
	reg        en;
	reg [15:0] amp;
	en  = speaker_en | (status[13] & ~dma_on);           // tape sound only while the tape runs
	amp = status[12:11] == 2'd0 ? 16'h2000 : status[12:11] == 2'd1 ? 16'h1000 :
	      status[12:11] == 2'd2 ? 16'h0800 : 16'h0000;
	snd <= !en ? 16'h0000 : tape_out ? amp : -amp;       // tape_out = the NE556 square
end
assign AUDIO_S = 1;
assign AUDIO_L = snd;
assign AUDIO_R = snd;

// ---------------------------------------------------------------- video
// Native timing: 128 dots x 312 lines at 2 MHz (64 us lines, 50.08 Hz).
// "Full": the visible area of a TV (104 dots x 288 lines) with the picture
// where the DREAM puts it; "Picture only": the 64 x 32 dots.
wire full = ~status[8];
wire hde_full = (hcount >= 7'd104) | (hcount < 7'd80);
wire vde_full = (vcount >= 9'd240) | (vcount < 9'd216);
wire hde_pic  = hcount < 7'd64;
wire vde_pic  = vcount < 9'd128;
wire HBlank = full ? ~hde_full : ~hde_pic;
wire VBlank = full ? ~vde_full : ~vde_pic;

wire [23:0] phosphor = status[7:6] == 2'd1 ? 24'h33FF66 :   // green
                      status[7:6] == 2'd2 ? 24'hFFB000 :   // amber
                                            24'hFFFFFF;    // white
wire [7:0] R, G, B;
assign {R, G, B} = pix ? phosphor : 24'h000000;

// pixel aspect: dot = 0.5 us of a 52 us line, 4 lines of 288 -> about square
assign VGA_SL = desk ? 2'd0 : status[10:9];
wire [11:0] arx = (full | desk) ? 12'd4  : 12'd24;
wire [11:0] ary = (full | desk) ? 12'd3  : 12'd13;

video_freak video_freak
(
	.CLK_VIDEO(CLK_VIDEO),
	.CE_PIXEL(CE_PIXEL),
	.VGA_VS(VGA_VS),
	.HDMI_WIDTH(HDMI_WIDTH),
	.HDMI_HEIGHT(HDMI_HEIGHT),
	.VGA_DE(VGA_DE),
	.VIDEO_ARX(VIDEO_ARX),
	.VIDEO_ARY(VIDEO_ARY),
	.VGA_DE_IN(desk ? ~(d_hb | d_vb) : vga_de),
	.ARX((!ar) ? arx : (ar - 1'd1)),
	.ARY((!ar) ? ary : 12'd0),
	.CROP_SIZE(0),
	.CROP_OFF(0),
	.SCALE(scale)
);

wire vga_de, ce_mix, m_hs, m_vs;
wire [7:0] m_r, m_g, m_b;
wire [7:0] d_r, d_g, d_b;
wire       d_hs, d_vs, d_hb, d_vb;
assign CLK_VIDEO = clk_sys;

video_mixer #(.LINE_LENGTH(140), .HALF_DEPTH(0), .GAMMA(1)) video_mixer
(
	.CLK_VIDEO(CLK_VIDEO),
	.CE_PIXEL(ce_mix),
	.ce_pix(ce_dot),
	.scandoubler(forced_scandoubler),
	.hq2x(1'b0),
	.gamma_bus(gamma_bus),
	.R(R), .G(G), .B(B),
	.HSync(hs),
	.VSync(vs),
	.HBlank(HBlank),
	.VBlank(VBlank),
	.HDMI_FREEZE(1'b0),
	.freeze_sync(),
	.VGA_R(m_r),
	.VGA_G(m_g),
	.VGA_B(m_b),
	.VGA_VS(m_vs),
	.VGA_HS(m_hs),
	.VGA_DE(vga_de)
);

// ---------------------------------------------------------------- Desk view (800x600@60)
d6800_desk desk_view
(
	.clk(clk_sys),
	.ce_dot(ce_dot),
	.pix(pix),
	.hcount(hcount),
	.vcount(vcount),
	.dot_rgb(phosphor),
	.key_down(key | mkey),
	.fn_down(fn | mfn),
	.rst_down(rst_key | mrst | status[0] | buttons[1]),
	.led_on(~dma_on | tape_adc_act),
	.cursor_show(mshow),
	.cursor_x(mx),
	.cursor_y(my),
	.r(d_r), .g(d_g), .b(d_b),
	.hs(d_hs), .vs(d_vs),
	.hblank(d_hb), .vblank(d_vb)
);

d6800_mouse mouse
(
	.clk(clk_sys),
	.reset(RESET),
	.enable(desk),
	.ps2_mouse(ps2_mouse),
	.mx(mx), .my(my),
	.mshow(mshow),
	.mkey(mkey), .mfn(mfn), .mrst(mrst)
);

// the view changes at once; the scaler follows the new timing
assign CE_PIXEL = desk ? 1'b1 : ce_mix;
assign VGA_R  = desk ? d_r  : m_r;
assign VGA_G  = desk ? d_g  : m_g;
assign VGA_B  = desk ? d_b  : m_b;
assign VGA_HS = desk ? d_hs : m_hs;
assign VGA_VS = desk ? d_vs : m_vs;

// ---------------------------------------------------------------- LEDs
assign LED_USER = ~dma_on | tape_adc_act;      // tape in use
assign LED_DISK = {1'b0, ioctl_download | auto_busy};

endmodule
