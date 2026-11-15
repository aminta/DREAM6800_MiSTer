// Desk view test: feeds art/sample_frame.txt through the native video inputs, then writes
// one 800x600 frame as PPM.  desk_tb OUT.ppm [overlays]  (overlays: key 5, FN, LED, pointer)
#include "Vd6800_desk.h"
#include <cstdio>
#include <cstring>
#include <vector>
#include <string>
int main(int argc, char **argv) {
    Vd6800_desk *t = new Vd6800_desk;
    bool ov = argc > 2;
    std::vector<std::string> fr;
    FILE *f = fopen("../art/sample_frame.txt", "r");
    char line[256];
    while (fgets(line, sizeof line, f)) fr.push_back(line);
    fclose(f);
    t->dot_rgb = ov ? 0x33ff66 : 0xffffff;
    t->key_down = ov ? (1 << 5) : 0;
    t->fn_down = ov; t->rst_down = 0; t->led_on = ov;
    t->cursor_show = ov; t->cursor_x = 690; t->cursor_y = 470;
    auto tick = [&]() { t->clk = 0; t->eval(); t->clk = 1; t->eval(); };
    // native frame: every clock one dot
    for (int v = 0; v < 312; v++)
        for (int h = 0; h < 128; h++) {
            t->ce_dot = 1; t->hcount = h; t->vcount = v;
            t->pix = (h < 64 && v < 128) ? fr[v / 4][h] == '#' : 0;
            tick();
        }
    t->ce_dot = 0;
    std::vector<unsigned char> img(800 * 600 * 3);
    // wait for vblank -> active, then capture 600 visible lines
    int state = 0, x = 0, y = 0;
    for (long i = 0; i < 4000000 && state < 3; i++) {
        tick();
        if (state == 0 && t->vblank) state = 1;
        else if (state == 1 && !t->vblank) state = 2;
        if (state == 2) {
            if (!t->vblank && !t->hblank) {
                unsigned char *p = &img[(y * 800 + x) * 3];
                p[0] = t->r; p[1] = t->g; p[2] = t->b;
                if (++x == 800) { x = 0; if (++y == 600) state = 3; }
            }
        }
    }
    FILE *o = fopen(argv[1], "wb");
    fprintf(o, "P6 800 600 255\n");
    fwrite(img.data(), 1, img.size(), o);
    fclose(o);
    printf("%s %s\n", argv[1], state == 3 ? "ok" : "INCOMPLETE");
    return 0;
}
