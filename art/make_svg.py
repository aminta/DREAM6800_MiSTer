#!/usr/bin/env python3
"""Draws the DREAM 6800 "Desk" view (800x600, 16-colour palette) as SVG.

The machine as in the Electronics Australia prototype (June 1979, ref/ea_pages p2-000):
a white PC board on a hardboard base under a perspex cover, a black 4x4 hex keypad with
white keys, the speaker, RST (left) and FN (right) push-buttons above the keypad; next to
it a 1970s TV set (picture: 64x32 dots, 5 px per dot) and a cassette recorder.

  make_svg.py draft.svg [frame.txt]   preview, with a 64x32 text frame on the TV
  make_svg.py bg.svg --bg             background for the FPGA (TV picture left black)
The --bg run also writes layout.json: palette, the TV picture rectangle, key rectangles.
Fonts: DejaVu Sans from art/fonts only; render with ./rsvg.sh."""
import json, sys

BG = '--bg' in sys.argv
args = [a for a in sys.argv[1:] if not a.startswith('--')]
OUT = args[0] if args else 'draft.svg'
FRAME = args[1] if len(args) > 1 else None

PAL = {
    'wall':    '#2b3038', 'desk':  '#5b4230', 'grain':  '#4b3626', 'cab':   '#a2a7ac',
    'cab2':    '#6d7379', 'bezel': '#2a2d31', 'black':  '#0e0f10', 'board': '#3c2e23',
    'perspex': '#6a5b4d', 'pcb':   '#e4dfd1', 'key':    '#f3f3ef', 'keysh': '#b9b9b1',
    'red':     '#ad2f29', 'wood':  '#7a5a3c', 'dot':    '#ffffff', 'led':   '#3a1414',
}
ORDER = list(PAL)          # palette index = position (dot and led are set by the HDL)
out = []
KEYS = {}

def rect(x, y, w, h, fill, rx=0, stroke=None, sw=1, op=None):
    s = f' stroke="{PAL[stroke]}" stroke-width="{sw}"' if stroke else ''
    o = f' opacity="{op}"' if op else ''
    out.append(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="{rx}" fill="{PAL[fill]}"{s}{o}/>')
def circle(cx, cy, r, fill, stroke=None, sw=1):
    s = f' stroke="{PAL[stroke]}" stroke-width="{sw}"' if stroke else ''
    out.append(f'<circle cx="{cx}" cy="{cy}" r="{r}" fill="{PAL[fill]}"{s}/>')
def line(x1, y1, x2, y2, col, w=1):
    out.append(f'<line x1="{x1}" y1="{y1}" x2="{x2}" y2="{y2}" stroke="{PAL[col]}" stroke-width="{w}"/>')
def path(d, col, w=1, fill='none'):
    f = PAL[fill] if fill != 'none' else 'none'
    out.append(f'<path d="{d}" stroke="{PAL[col]}" stroke-width="{w}" fill="{f}" stroke-linecap="round"/>')
def text(x, y, s, size, fill='black', weight='bold', anchor='middle'):
    out.append(f'<text x="{x}" y="{y}" font-family="DejaVu Sans" font-size="{size}" '
               f'font-weight="{weight}" text-anchor="{anchor}" fill="{PAL[fill]}">{s}</text>')

# ------------------------------------------------------------------ room
rect(0, 0, 800, 600, 'wall')
DESK_Y = 400
rect(0, DESK_Y, 800, 200, 'desk')
for i, y in enumerate(range(DESK_Y + 9, 600, 13)):                # wood grain
    x0 = (i * 97) % 180
    path(f'M{x0 - 200},{y} C{x0 + 100},{y - 3} {x0 + 300},{y + 3} {x0 + 1000},{y - 1}', 'grain', 1)
rect(0, DESK_Y, 800, 3, 'grain')

# ------------------------------------------------------------------ TV (front view)
TX, TY, TW, TH = 40, 26, 580, 372
rect(TX + 30, TY + TH - 4, 30, 8, 'black')                       # feet
rect(TX + TW - 60, TY + TH - 4, 30, 8, 'black')
rect(TX, TY, TW, TH - 4, 'wood', 12)                             # wooden cabinet
rect(TX + 8, TY + 8, TW - 16, TH - 20, 'cab', 6)                 # silver front
SX, SY, SW, SH = TX + 22, TY + 22, 460, 322                      # screen opening
rect(SX - 6, SY - 6, SW + 12, SH + 12, 'bezel', 26)
rect(SX, SY, SW, SH, 'black', 22)
DOT = 5
PW, PH = 64 * DOT, 32 * DOT
PX, PY = SX + (SW - PW) // 2, SY + 70                            # the picture sits high, as on the DREAM
if FRAME and not BG:
    rows = [l.rstrip('\n') for l in open(FRAME)][:32]
    for y, r in enumerate(rows):
        for x, c in enumerate(r[:64]):
            if c == '#':
                rect(PX + x * DOT, PY + y * DOT, DOT, DOT, 'dot')
# control panel
CX = SX + SW + 14
rect(CX, SY - 6, TX + TW - 14 - CX, SH + 12, 'cab2', 4)
for k, ky in enumerate((SY + 34, SY + 104)):
    circle(CX + 40, ky, 24, 'black')
    circle(CX + 40, ky, 18, 'cab')
    line(CX + 40, ky - 16, CX + 40, ky - 4, 'black', 3)
for y in range(SY + 160, SY + SH - 14, 7):                       # speaker grille
    line(CX + 14, y, TX + TW - 28, y, 'black', 2)
rect(CX + 18, SY + 138, 44, 8, 'black', 2)                       # power switch
circle(CX + 70, SY + 142, 3, 'red')                              # power lamp

# ------------------------------------------------------------------ cassette recorder (front)
RX, RY, RW, RH = 640, 296, 146, 102
rect(RX, RY, RW, RH, 'black', 6)
rect(RX + 6, RY + 6, RW - 12, 44, 'bezel', 3)
rect(RX + 34, RY + 12, 78, 32, 'black', 3)                       # cassette window
circle(RX + 56, RY + 28, 7, 'cab2'); circle(RX + 90, RY + 28, 7, 'cab2')
circle(RX + 56, RY + 28, 3, 'black'); circle(RX + 90, RY + 28, 3, 'black')
for i in range(5):                                               # piano keys
    rect(RX + 12 + i * 25, RY + 60, 21, 14, 'red' if i == 0 else 'cab', 2)
for y in range(RY + 82, RY + RH - 6, 5):
    line(RX + 14, y, RX + RW - 50, y, 'cab2', 2)
LED = (RX + RW - 24, RY + 88)
circle(LED[0], LED[1], 5, 'led')                                 # tape LED (HDL: on while the tape runs)

# ------------------------------------------------------------------ cables from the board
path('M300,428 C300,410 280,404 270,398', 'black', 4)            # video to the TV
path('M452,430 C470,410 640,420 660,398', 'black', 3)            # tape to the recorder
path('M60,500 C30,505 15,540 0,545', 'black', 4)                 # power

# ------------------------------------------------------------------ base, board (top view)
BX, BY, BW, BH = 28, 414, 744, 178
rect(BX + 3, BY + 4, BW, BH, 'grain', 6)                         # shadow
rect(BX, BY, BW, BH, 'board', 6)
rect(BX + 2, BY + 2, BW - 4, BH - 4, 'board', 5, stroke='perspex', sw=2)   # perspex cover edge
for (cx, cy) in ((BX + 12, BY + 12), (BX + BW - 12, BY + 12), (BX + 12, BY + BH - 12), (BX + BW - 12, BY + BH - 12)):
    circle(cx, cy, 4, 'cab')
PCX, PCY, PCW, PCH = 50, 426, 410, 154
rect(PCX, PCY, PCW, PCH, 'pcb', 2)
for (cx, cy) in ((PCX + 7, PCY + 7), (PCX + PCW - 7, PCY + 7), (PCX + 7, PCY + PCH - 7), (PCX + PCW - 7, PCY + PCH - 7)):
    circle(cx, cy, 3, 'cab2')

def dip(x, y, pins, vertical=True, window=False):
    n = pins // 2
    L, W = n * 5 + 4, 12 if pins <= 18 else 20
    w, h = (W, L) if vertical else (L, W)
    rect(x, y, w, h, 'black', 1)
    for i in range(n):
        if vertical:
            line(x - 2, y + 4 + i * 5, x, y + 4 + i * 5, 'cab2', 2)
            line(x + w, y + 4 + i * 5, x + w + 2, y + 4 + i * 5, 'cab2', 2)
        else:
            line(x + 4 + i * 5, y - 2, x + 4 + i * 5, y, 'cab2', 2)
            line(x + 4 + i * 5, y + h, x + 4 + i * 5, y + h + 2, 'cab2', 2)
    if vertical:
        circle(x + w / 2, y + 3, 2, 'bezel')
    else:
        circle(x + 3, y + h / 2, 2, 'bezel')
    if window:
        rect(x + 4, y + h / 2 - 8, w - 8, 16, 'cab2', 2)

# TTL rows (video generator, decoding) on the left, as in the photo
for col, x in enumerate((66, 92, 128, 154, 190)):
    for row, y in enumerate((440, 496)):
        dip(x, y, 14 if (col + row) % 2 else 16)
dip(66, 546, 16, vertical=False); dip(128, 546, 14, vertical=False)
dip(226, 438, 24, window=True)                    # 2708 EPROM (CHIPOS) with its window
dip(262, 436, 18); dip(282, 436, 18)              # 2114 RAM x2
dip(310, 440, 40, vertical=False)                 # MC6800 CPU
dip(310, 500, 40, vertical=False)                 # MC6821 PIA
dip(226, 520, 16); dip(250, 520, 14)
dip(420, 440, 16)                                 # MC6875 clock
for i in range(6):                                # capacitors / resistors
    rect(400 + (i % 3) * 14, 520 + (i // 3) * 22, 8, 14, 'bezel' if i % 2 else 'red', 3)
rect(424, 468, 22, 10, 'cab', 2)                  # crystal
text(PCX + 70, PCY + PCH - 6, 'DREAM 6800', 9, 'black')

# wires: ribbon to the keypad, speaker pair
for i in range(6):
    path(f'M{PCX + PCW},{540 + i * 3} C{PCX + PCW + 60},{540 + i * 3} {560},{522 + i * 3} {598},{522 + i * 3}', 'cab', 1.5)
path('M460,452 C490,452 500,470 512,476', 'red', 2)
path('M460,456 C490,458 498,476 510,480', 'black', 2)

# speaker
SPX, SPY = 532, 498
circle(SPX, SPY, 40, 'cab2'); circle(SPX, SPY, 34, 'black')
circle(SPX, SPY, 22, 'bezel'); circle(SPX, SPY, 9, 'cab2')

# RST and FN push-buttons above the keypad (RST left, FN right)
KX, KY, KS, KG = 604, 448, 30, 6
def button(cx, cy, label, col, code):
    circle(cx, cy, 11, 'cab'); circle(cx, cy, 8, col)
    text(cx + (-24 if label == 'RST' else 22), cy + 4, label, 11, 'key')
    KEYS[code] = [cx - 11, cy - 9, cx + 11, cy + 9]   # stops above the keypad case (y 440)
button(KX + 46, 430, 'RST', 'red', 'RST')
button(KX + 112, 430, 'FN', 'black', 'FN')

# keypad 4x4: 0 1 2 3 / 4 5 6 7 / 8 9 A B / C D E F
rect(KX - 8, KY - 8, 4 * KS + 3 * KG + 16, 4 * KS + 3 * KG + 16 - 6, 'black', 6)
for r in range(4):
    for c in range(4):
        x, y = KX + c * (KS + KG), KY + r * (KS + KG - 2)
        code = r * 4 + c
        rect(x, y + 2, KS, KS - 4, 'keysh', 4)
        rect(x, y, KS, KS - 5, 'key', 4)
        text(x + KS / 2, y + KS / 2 + 2, '%X' % code, 14, 'black')
        KEYS[code] = [x, y, x + KS - 1, y + KS - 3]

svg = ('<svg xmlns="http://www.w3.org/2000/svg" width="800" height="600" shape-rendering="crispEdges">\n'
       + '\n'.join(out) + '\n</svg>\n')
open(OUT, 'w').write(svg)
if BG:
    json.dump({'palette': [PAL[n] for n in ORDER], 'names': ORDER,
               'picture': [PX, PY, DOT], 'led': LED, 'keys': KEYS},
              open('layout.json', 'w'), indent=1)
print(OUT)
