// DREAM 6800 input: PC keyboard + joystick -> hex keypad, FN and RST,
// plus the "autotype" used after a quick load (RST is done by the caller,
// then this types the run address and FN 3 as a user would).
//
// Keyboard: 0-9 and A-F (main row or numpad 0-9) = hex keys,
//           Space / Shift = FN, Esc = RST.
//           Arrows follow the joystick preset.
// Joystick presets (joy_map):
//   0: up 2, down 8, left 4, right 6, fire 5   (COSMAC VIP style games)
//   1: left 0, right 1, fire 3                 (Dream Invaders)
//   2: Bauer's analog joystick (DREAMER 3): stick or arrows -> joy_x/joy_y,
//      fire = key F.  An analog stick sets the position directly (springs back
//      to the centre); the d-pad / arrows move it 4 steps per frame and it stays.
//   3: off

module d6800_input (
    input  logic        clk,
    input  logic        reset,
    input  logic [10:0] ps2_key,
    input  logic [31:0] joy,          // [3]=up [2]=down [1]=left [0]=right [4]=fire [5]=FN [6]=RST
    input  logic [15:0] joy_a,        // analog stick: [7:0] X, [15:8] Y, signed
    input  logic [1:0]  joy_map,
    input  logic        frame,        // one pulse per video frame
    input  logic        auto_start,   // pulse: type the start sequence
    input  logic [15:0] auto_run,     // run address: types "<auto_run> FN 3"
    output logic [15:0] key,
    output logic [7:0]  stick_x,      // Bauer joystick position, 0 = left / top
    output logic [7:0]  stick_y,
    output logic        fn,
    output logic        rst,
    output logic        auto_busy
);

    // ------------------------------------------------------------ keyboard
    logic [15:0] kb_key;
    logic        kb_fn_sp, kb_fn_ls, kb_fn_rs, kb_rst;
    logic        kb_up, kb_dn, kb_lt, kb_rt;
    logic        old_stb;

    always_ff @(posedge clk) begin
        old_stb <= ps2_key[10];
        if (reset) begin
            kb_key <= 0; {kb_fn_sp, kb_fn_ls, kb_fn_rs, kb_rst} <= 0; {kb_up, kb_dn, kb_lt, kb_rt} <= 0;
        end
        else if (old_stb != ps2_key[10]) begin
            if (ps2_key[8]) begin
                case (ps2_key[7:0])
                    8'h75: kb_up <= ps2_key[9];
                    8'h72: kb_dn <= ps2_key[9];
                    8'h6B: kb_lt <= ps2_key[9];
                    8'h74: kb_rt <= ps2_key[9];
                    default: ;
                endcase
            end
            else begin
                case (ps2_key[7:0])
                    8'h45, 8'h70: kb_key[0]  <= ps2_key[9];
                    8'h16, 8'h69: kb_key[1]  <= ps2_key[9];
                    8'h1E, 8'h72: kb_key[2]  <= ps2_key[9];
                    8'h26, 8'h7A: kb_key[3]  <= ps2_key[9];
                    8'h25, 8'h6B: kb_key[4]  <= ps2_key[9];
                    8'h2E, 8'h73: kb_key[5]  <= ps2_key[9];
                    8'h36, 8'h74: kb_key[6]  <= ps2_key[9];
                    8'h3D, 8'h6C: kb_key[7]  <= ps2_key[9];
                    8'h3E, 8'h75: kb_key[8]  <= ps2_key[9];
                    8'h46, 8'h7D: kb_key[9]  <= ps2_key[9];
                    8'h1C: kb_key[10] <= ps2_key[9];
                    8'h32: kb_key[11] <= ps2_key[9];
                    8'h21: kb_key[12] <= ps2_key[9];
                    8'h23: kb_key[13] <= ps2_key[9];
                    8'h24: kb_key[14] <= ps2_key[9];
                    8'h2B: kb_key[15] <= ps2_key[9];
                    8'h29: kb_fn_sp <= ps2_key[9];
                    8'h12: kb_fn_ls <= ps2_key[9];
                    8'h59: kb_fn_rs <= ps2_key[9];
                    8'h76: kb_rst   <= ps2_key[9];
                    default: ;
                endcase
            end
        end
    end

    // ------------------------------------------------------------ joystick
    wire up = joy[3] | kb_up, dn = joy[2] | kb_dn, lt = joy[1] | kb_lt, rt = joy[0] | kb_rt;
    logic [15:0] jkey;
    always_comb begin
        jkey = 0;
        case (joy_map)
            2'd0: begin
                jkey[2] = up; jkey[8] = dn; jkey[4] = lt; jkey[6] = rt; jkey[5] = joy[4];
            end
            2'd1: begin
                jkey[0] = lt; jkey[1] = rt; jkey[3] = joy[4] | up;
            end
            2'd2: jkey[15] = joy[4];
            default: ;
        endcase
    end

    // ------------------------------------------------------------ Bauer joystick
    wire signed [7:0] ax = joy_a[7:0], ay = joy_a[15:8];
    wire  a_moved = ax > 8'sd24 || ax < -8'sd24 || ay > 8'sd24 || ay < -8'sd24;
    logic analog;                     // last input came from the analog stick
    logic [7:0] px, py;
    always_ff @(posedge clk) begin
        if (reset) begin analog <= 0; px <= 8'd128; py <= 8'd128; end
        else if (joy_map != 2'd2) begin analog <= 0; px <= 8'd128; py <= 8'd128; end
        else begin
            if (a_moved) analog <= 1;
            if (up | dn | lt | rt) analog <= 0;
            if (analog) begin px <= {~ax[7], ax[6:0]}; py <= {~ay[7], ay[6:0]}; end
            else if (frame) begin
                if (lt) px <= px < 8'd4   ? 8'd0   : px - 8'd4;
                if (rt) px <= px > 8'd251 ? 8'd255 : px + 8'd4;
                if (up) py <= py < 8'd4   ? 8'd0   : py - 8'd4;
                if (dn) py <= py > 8'd251 ? 8'd255 : py + 8'd4;
            end
        end
    end
    assign stick_x = px;
    assign stick_y = py;

    // ------------------------------------------------------------ autotype
    // sequence of 6 keys; each held 3 frames, then released 6 frames.
    // Starts 25 frames after auto_start (CHIPOS start-up after RST).
    logic [2:0]  a_idx;
    logic [5:0]  a_cnt;
    logic        a_on;
    logic [4:0]  a_code;     // 0-15 hex, 16 = FN
    always_comb begin
        case (a_idx)
            3'd0: a_code = {1'b0, auto_run[15:12]};
            3'd1: a_code = {1'b0, auto_run[11:8]};
            3'd2: a_code = {1'b0, auto_run[7:4]};
            3'd3: a_code = {1'b0, auto_run[3:0]};
            3'd4: a_code = 5'd16;
            default: a_code = 5'd3;
        endcase
    end
    logic a_press;
    always_ff @(posedge clk) begin
        if (reset) begin a_on <= 0; a_press <= 0; end
        else if (auto_start) begin a_on <= 1; a_idx <= 0; a_cnt <= 6'd25; a_press <= 0; end
        else if (a_on && frame) begin
            if (a_cnt != 0) a_cnt <= a_cnt - 1'd1;
            else if (!a_press) begin a_press <= 1; a_cnt <= 6'd2; end
            else begin
                a_press <= 0; a_cnt <= 6'd5;
                if (a_idx == 3'd5) a_on <= 0;
                else a_idx <= a_idx + 1'd1;
            end
        end
    end
    wire [15:0] akey = (a_on && a_press && a_code < 16) ? (16'd1 << a_code[3:0]) : 16'd0;
    wire        afn  = a_on && a_press && a_code == 5'd16;

    assign key       = kb_key | jkey | akey;
    assign fn        = kb_fn_sp | kb_fn_ls | kb_fn_rs | joy[5] | afn;
    assign rst       = kb_rst | joy[6];
    assign auto_busy = a_on;

endmodule
