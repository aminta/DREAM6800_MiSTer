#!/usr/bin/env python3
"""Hex listings from DREAMER scans (archive.org PDFs) -> program files.

  listing.py ocr PDF PAGE [PAGE2 ...]   OCR the hex lines of the pages (tesseract, 300 dpi)
  listing.py build LISTING OUT [RUN]    listing -> program file: .c8/.bin = data from the first
                                        address (must be 0200); .d68 = load address, RUN address
                                        (hex, 2 bytes each, high first), then the data
  listing.py diff LISTING OCRTEXT       words that differ between a hand transcription and the OCR
  listing.py check FILE.c8|.d68         CHIP-8 (CHIPOS dialect) control-flow check from 0200: invalid
                                        opcodes on reachable paths, jumps outside the program

Listing format: one line per row, "ADDR  w w w ...", words of 4 hex digits (CHIP-8 instructions)
or 2 hex digits (bytes); '#' starts a comment.  Rows must be contiguous (a gap is filled with 00
and reported).  Two independent readings (by eye and OCR) are compared with 'diff'."""
import re, subprocess, sys, tempfile, os

FIX = str.maketrans({'O': '0', 'o': '0', 'D': 'D', 'l': '1', 'I': '1', 'i': '1', '|': '1', 'S': '5',
                     'B': 'B', 'Z': '2', 'G': '6', 'Q': '0'})
ROW = re.compile(r'^\s*([0-9A-F]{4})\s+((?:[0-9A-F]{2,4}\s*)+)$')

def parse(text):
    rows = []
    for line in text.splitlines():
        line = line.split('#')[0].strip().upper()
        m = ROW.match(line)
        if m:
            rows.append((int(m.group(1), 16), m.group(2).split()))
    return rows

def ocr(pdf, pages):
    out = []
    with tempfile.TemporaryDirectory() as d:
        for p in pages:
            subprocess.run(['pdftoppm', '-f', str(p), '-l', str(p), '-r', '300', '-png', pdf, f'{d}/p'], check=True)
            png = sorted(os.listdir(d))[-1]
            t = subprocess.run(['tesseract', f'{d}/{png}', '-', '--psm', '6'], capture_output=True, text=True).stdout
            for line in t.splitlines():
                w = line.translate(FIX).split()
                if len(w) >= 3 and re.fullmatch(r'[0-9A-F]{4}', w[0]):
                    out.append(' '.join(w))
            os.remove(f'{d}/{png}')
    return '\n'.join(out)

def build(listing, outpath, run=None):
    rows = parse(open(listing).read())
    data, start = bytearray(), rows[0][0]
    for addr, words in rows:
        if addr != start + len(data):
            print(f'gap/overlap at {addr:04X} (expected {start + len(data):04X})')
            if addr > start + len(data): data += bytes(addr - start - len(data))
            else: data = data[:addr - start]
        for w in words:
            data += bytes.fromhex(w)
    if outpath.lower().endswith('.d68'):
        assert run is not None, 'a .d68 file needs the run address'
        data = bytes([start >> 8, start & 255, run >> 8, run & 255]) + data
    else:
        assert start == 0x200, f'.c8/.bin files load at 0200, this listing starts at {start:04X}: use .d68'
    open(outpath, 'wb').write(data)
    print(f'{outpath}: {len(data)} bytes, {start:04X}-{start + len(data) - 1 - (4 if run is not None else 0):04X}'
          + (f', run {run:04X}' if run is not None else ''))

def diff(listing, ocrfile):
    a = {addr: w for addr, w in parse(open(listing).read())}
    b = {addr: w for addr, w in parse(open(ocrfile).read())}
    bad = 0
    for addr in sorted(a):
        if addr not in b: print(f'{addr:04X}: not in OCR'); continue
        for i, (x, y) in enumerate(zip(a[addr], b[addr])):
            if x != y: print(f'{addr:04X} word {i}: hand {x}  ocr {y}'); bad += 1
        if len(a[addr]) != len(b[addr]): print(f'{addr:04X}: {len(a[addr])} vs {len(b[addr])} words')
    print(f'{bad} differing words')

MISC = {0x07, 0x0A, 0x15, 0x18, 0x1E, 0x29, 0x33, 0x55, 0x65}

def check(path, base=0x200):
    """Trace every reachable instruction (both ways of each skip) in the CHIPOS dialect."""
    d = open(path, 'rb').read()
    if path.lower().endswith('.d68'):        # CHIP-8 still starts at 0200 (run C000)
        base, d = d[0] << 8 | d[1], d[4:]
    end = base + len(d)
    seen, todo, warn, mls = set(), [0x200], [], set()
    while todo:
        pc = todo.pop()
        while True:
            if pc in seen: break
            if pc < base or pc + 1 >= end or pc & 1:
                warn.append(f'flow reaches {pc:04X} (outside the program or odd)'); break
            seen.add(pc)
            op = d[pc - base] << 8 | d[pc - base + 1]
            n, x, y, kk, nnn = op >> 12, op >> 8 & 15, op >> 4 & 15, op & 255, op & 0xFFF
            nxt = pc + 2
            if n == 0:
                if op == 0x00EE: break
                if op not in (0x0000, 0x00E0) and op & 0xFF00: mls.add(nnn)
            elif n == 1: nxt = nnn
            elif n == 2: todo.append(nnn)
            elif n in (3, 4, 5, 9) or (n == 14):
                if n in (5, 9) and op & 15: warn.append(f'{pc:04X}: {op:04X} unusual (low nibble not 0)')
                if n == 14 and kk not in (0x9E, 0xA1): warn.append(f'{pc:04X}: {op:04X} unknown EX op')
                todo.append(pc + 4)
            elif n == 8 and op & 15 not in (0, 1, 2, 4, 5):
                warn.append(f'{pc:04X}: {op:04X} 8XY{op & 15:X} not in CHIPOS (no effect)')
            elif n == 11:
                warn.append(f'{pc:04X}: {op:04X} jump + V0, not followed'); break
            elif n == 15 and kk not in MISC:
                warn.append(f'{pc:04X}: {op:04X} unknown FX op (CHIPOS returns to the monitor)'); break
            pc = nxt
    print(f'{path}: {len(d)} bytes from {base:04X}, {len(seen)} CHIP-8 instructions reachable from 0200 ({2 * len(seen) * 100 // len(d)} % of the file)')
    for w in warn: print('  ' + w)
    for m in sorted(mls): print(f'  machine-code call to {m:04X}')
    return not warn

if __name__ == '__main__':
    cmd = sys.argv[1]
    if cmd == 'ocr': print(ocr(sys.argv[2], [int(p) for p in sys.argv[3:]]))
    elif cmd == 'build': build(sys.argv[2], sys.argv[3], int(sys.argv[4], 16) if len(sys.argv) > 4 else None)
    elif cmd == 'diff': diff(sys.argv[2], sys.argv[3])
    elif cmd == 'check': sys.exit(0 if check(sys.argv[2]) else 1)
