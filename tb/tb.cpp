// Verilator testbench for the DREAM 6800 machine (rtl/dream6800.sv).
// Reads a script (stdin or file) and prints 64x32 frames as text.
//
// Script commands (one per line, '#' comments):
//   rom FILE            load CHIPOS (1 KB) into the ROM
//   ramsize 0|1|2       1K / 2K / 4K
//   turbo 0|1
//   load ADDR FILE      write FILE into RAM at ADDR (hex); a .d68 loads at its own address
//   poke ADDR BYTE..    write bytes into RAM (hex)
//   reset               RST pulse
//   boot ADDR           reset, first instruction fetched from ADDR (quick load)
//   run N               run N frames
//   keys STR            type keys: 0-9 A-F hex keys, '*' = FN; each key held
//                       KD frames then released KU frames (see 'keytime')
//   keytime KD KU
//   hold K N            hold key K ('*' = FN) down for N frames, then release
//   dump [LABEL]        print the current frame (# = white)
//   mem ADDR LEN        print RAM bytes
//   stats               print counters for the last frame
//   tapeloop 0|1        connect tape out to tape in
//   stick X Y           Bauer joystick position, 0..255 each (default 128 128)
//   tapeadc FILE GAIN   same as tapein, through a model of the MiSTer ADC (ltc2308_tape):
//                       12-bit value = max(0, (smp-128)*GAIN), 4-sample average, 16/64 hysteresis
//   tapeout FILE        start recording tape out as 8-bit 48 kHz raw (until end)
//   tapein FILE         play 8-bit 48 kHz raw unsigned into tape in
#include "Vdream6800.h"
#include "verilated.h"
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <string>
#include <vector>
#include <fstream>
#include <sstream>
#include <iostream>

static const int CPU_DIV = 4;           // must match -GCPU_DIV
static const double CLK_HZ = 1e6 * CPU_DIV;

static Vdream6800* m;
static uint64_t clk_count = 0;
static uint8_t img[32][64];
static uint64_t frame = 0;
static bool tapeloop = false;
static FILE* tape_out_f = nullptr;
static std::vector<uint8_t> tape_in_buf;
static int adc_gain = 0;           // 0 = comparator (tapein), else ADC model
static int adc_hist[4];
static size_t tape_in_pos = 0;
static double tape_phase = 0;

// per-frame counters
static uint64_t f_cpu_cycles, f_cpu_active, f_spk_toggles, f_irq_edges;
static uint64_t l_cpu_cycles, l_cpu_active, l_spk_toggles, l_irq_edges;
static int prev_spk = 0, prev_cb1 = 0;

static void tick() {
    m->clk = 0; m->eval();
    m->clk = 1; m->eval();
    clk_count++;
    // tape I/O at 48 kHz
    tape_phase += 48000.0 / CLK_HZ;
    if (tape_phase >= 1.0) {
        tape_phase -= 1.0;
        if (tape_out_f) fputc(m->tape_out ? 0xC0 : 0x40, tape_out_f);
        if (!tapeloop && tape_in_pos < tape_in_buf.size())
        {   // comparator with hysteresis (like the 741 with AC coupling)
            int smp = tape_in_buf[tape_in_pos++];
            if (adc_gain) {
                int v = (smp - 128) * adc_gain;
                v = v < 0 ? 0 : v > 4095 ? 4095 : v;
                int sum = adc_hist[0] + adc_hist[1] + adc_hist[2] + adc_hist[3];
                adc_hist[0] = adc_hist[1]; adc_hist[1] = adc_hist[2]; adc_hist[2] = adc_hist[3]; adc_hist[3] = v;
                if (sum / 4 < 16) m->tape_in = 0;
                if (sum / 4 > 64) m->tape_in = 1;
            }
            else if (smp > 0x80 + 12) m->tape_in = 1;
            else if (smp < 0x80 - 12) m->tape_in = 0;
        }
    }
    if (tapeloop) m->tape_in = m->tape_out;

    if (m->dbg_ce) {
        f_cpu_cycles++;
        if (!m->dbg_halted) f_cpu_active++;
    }
    if (m->speaker != prev_spk) { f_spk_toggles++; prev_spk = m->speaker; }
    if (m->ce_dot) {
        int h = m->hcount, v = m->vcount;
        // the dot output is for the current h before the edge: sample pix now
        if (v < 128 && h < 64 && (v & 3) == 0) img[v >> 2][h] = m->pix;
        if (v == 224 && h == 0 && !prev_cb1) { f_irq_edges++; }
        prev_cb1 = (v == 224);
        if (h == 127 && v == 311) {
            frame++;
            l_cpu_cycles = f_cpu_cycles; l_cpu_active = f_cpu_active;
            l_spk_toggles = f_spk_toggles; l_irq_edges = f_irq_edges;
            f_cpu_cycles = f_cpu_active = f_spk_toggles = f_irq_edges = 0;
        }
    }
}

static void run_frames(int n) {
    uint64_t target = frame + n;
    while (frame < target) tick();
}

static int keyidx(char c) {
    if (c == '*') return 16;
    if (c >= '0' && c <= '9') return c - '0';
    if (c >= 'A' && c <= 'F') return c - 'A' + 10;
    if (c >= 'a' && c <= 'f') return c - 'a' + 10;
    return -1;
}

static void set_key(int k, bool down) {
    if (k == 16) m->fn = down;
    else if (down) m->key |= (1u << k);
    else m->key &= ~(1u << k);
}

static void dl(bool rom, int addr, uint8_t data) {
    m->dl_we = 1; m->dl_rom = rom; m->dl_addr = addr; m->dl_data = data;
    tick();
    m->dl_we = 0;
}

static void do_reset(bool ovr, int addr) {
    m->reset = 1;
    m->boot_ovr = ovr; m->boot_addr = addr;
    for (int i = 0; i < CPU_DIV * 8; i++) tick();
    m->reset = 0; m->boot_ovr = 0;
}

static std::vector<uint8_t> readfile(const std::string& fn) {
    std::ifstream f(fn, std::ios::binary);
    if (!f) { fprintf(stderr, "cannot open %s\n", fn.c_str()); exit(1); }
    return std::vector<uint8_t>((std::istreambuf_iterator<char>(f)), {});
}

static void dump(const std::string& label) {
    printf("=== frame %llu %s\n", (unsigned long long)frame, label.c_str());
    for (int y = 0; y < 32; y++) {
        for (int x = 0; x < 64; x++) putchar(img[y][x] ? '#' : '.');
        putchar('\n');
    }
}

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    m = new Vdream6800;
    m->reset = 1; m->ram_size = 2; m->turbo = 0; m->key = 0; m->fn = 0; m->joy_x = 128; m->joy_y = 128;
    m->tape_in = 0; m->dl_we = 0; m->boot_ovr = 0;
    for (int i = 0; i < 100; i++) tick();

    std::istream* in = &std::cin;
    std::ifstream fin;
    if (argc > 1 && argv[argc-1][0] != '+') { fin.open(argv[argc-1]); in = &fin; }

    int kd = 3, ku = 6;
    std::string line;
    while (std::getline(*in, line)) {
        auto hash = line.find('#');
        if (hash != std::string::npos) line = line.substr(0, hash);
        std::istringstream ss(line);
        std::string cmd; if (!(ss >> cmd)) continue;
        if (cmd == "rom") {
            std::string fn; ss >> fn; auto d = readfile(fn);
            for (size_t i = 0; i < d.size() && i < 1024; i++) dl(true, i, d[i]);
        } else if (cmd == "ramsize") { int v; ss >> v; m->ram_size = v;
        } else if (cmd == "stick") { int x, y; ss >> x >> y; m->joy_x = x; m->joy_y = y;
        } else if (cmd == "turbo") { int v; ss >> v; m->turbo = v;
        } else if (cmd == "load") {
            std::string a, fn; ss >> a; std::getline(ss >> std::ws, fn); int addr = strtol(a.c_str(), 0, 16);   // file name may have spaces
            auto d = readfile(fn);
            if (fn.size() > 4 && fn.substr(fn.size() - 4) == ".d68") {   // load address from the header
                addr = d[0] << 8 | d[1]; d.erase(d.begin(), d.begin() + 4); }
            for (size_t i = 0; i < d.size(); i++) dl(false, (addr + i) & 0xFFF, d[i]);
        } else if (cmd == "poke") {
            std::string a, b; ss >> a; int addr = strtol(a.c_str(), 0, 16);
            while (ss >> b) dl(false, (addr++) & 0xFFF, strtol(b.c_str(), 0, 16));
        } else if (cmd == "reset") { do_reset(false, 0);
        } else if (cmd == "boot") { std::string a; ss >> a; do_reset(true, strtol(a.c_str(), 0, 16));
        } else if (cmd == "run") { int n; ss >> n; run_frames(n);
        } else if (cmd == "keytime") { ss >> kd >> ku;
        } else if (cmd == "keys") {
            std::string s; ss >> s;
            for (char c : s) { int k = keyidx(c); if (k < 0) continue;
                set_key(k, true); run_frames(kd); set_key(k, false); run_frames(ku); }
        } else if (cmd == "hold") {
            std::string s; int n; ss >> s >> n; int k = keyidx(s[0]);
            set_key(k, true); run_frames(n); set_key(k, false);
        } else if (cmd == "dump") { std::string l; std::getline(ss, l); dump(l);
        } else if (cmd == "mem") {
            std::string a; int len; ss >> a >> len; int addr = strtol(a.c_str(), 0, 16);
            printf("mem %04X:", addr);
            for (int i = 0; i < len; i++) { m->dbg_raddr = (addr + i) & 0xFFF; m->eval(); printf(" %02X", m->dbg_rdata); }
            printf("\n");
        } else if (cmd == "trace") {
            int n; ss >> n;
            while (n > 0) { tick(); if (m->dbg_ce && m->dbg_vma && !m->dbg_halted) {
                printf("%04X %c %02X\n", m->dbg_addr, m->dbg_rw ? 'r' : 'W', m->dbg_rw ? m->dbg_din : m->dbg_dout); n--; } }
        } else if (cmd == "stats") {
            printf("stats frame %llu: cpu_cycles %llu active %llu spk_toggles %llu rtc %llu\n",
                (unsigned long long)frame, (unsigned long long)l_cpu_cycles,
                (unsigned long long)l_cpu_active, (unsigned long long)l_spk_toggles,
                (unsigned long long)l_irq_edges);
        } else if (cmd == "tapeloop") { int v; ss >> v; tapeloop = v;
        } else if (cmd == "tapeout") { std::string fn; ss >> fn; tape_out_f = fopen(fn.c_str(), "wb");
        } else if (cmd == "tapeadc") { std::string fn; ss >> fn >> adc_gain; tape_in_buf = readfile(fn); tape_in_pos = 0;
        } else if (cmd == "tapein") { std::string fn; ss >> fn; tape_in_buf = readfile(fn); tape_in_pos = 0; adc_gain = 0;
        } else { fprintf(stderr, "unknown command: %s\n", cmd.c_str()); return 1; }
        fflush(stdout);
    }
    if (tape_out_f) fclose(tape_out_f);
    delete m;
    return 0;
}
