#!/usr/bin/env python3
"""Decode a DREAM 6800 cassette recording (Kansas City FSK, 300 baud) into bytes.

    tape2bin.py TAPE.(mp3|wav|...) OUT.bin [--max N]

Works like CHIPOS + the EA demodulator: 2400 Hz = 1 (mark), 1200 Hz = 0 (space);
each byte = start bit (0), 8 data bits LSB first, stop bit (1).  The tape has
no header or length: decoding stops when the tone ends (or after --max bytes).
Audio is converted with ffmpeg to 48 kHz mono.
"""
import subprocess, sys, argparse

RATE = 48000
BIT = RATE / 300.0                      # samples per bit (160)

def load(path):
    raw = subprocess.run(['ffmpeg', '-v', 'error', '-i', path, '-ac', '1', '-ar', str(RATE),
                          '-f', 's16le', '-'], capture_output=True, check=True).stdout
    return [int.from_bytes(raw[i:i+2], 'little', signed=True) for i in range(0, len(raw), 2)]

def tone_track(s):
    """Per-sample tone: 1 = 2400 Hz, 0 = 1200 Hz, None = silence.  Comparator with
    hysteresis; tone from the length of the last full cycle (threshold 625 us)."""
    peak = max(1, max(abs(x) for x in s))
    hi, lo = peak * 0.08, -peak * 0.08
    state, last_rise, cur = 0, None, None
    out = [None] * len(s)
    for i, x in enumerate(s):
        if state == 0 and x > hi:
            state = 1
            if last_rise is not None:
                period = (i - last_rise) / RATE
                cur = 1 if period < 625e-6 else (0 if period < 1.6e-3 else None)
            last_rise = i
        elif state == 1 and x < lo:
            state = 0
        if last_rise is not None and i - last_rise > RATE * 2e-3:
            cur = None                     # no edge for 2 ms: silence
        out[i] = cur
    return out

def decode(track, maxbytes=None):
    data, i, n = [], 0, len(track)
    while i < n:
        # wait for a start bit (space after mark)
        while i < n and track[i] != 0:
            i += 1
        if i >= n:
            break
        mid = i + BIT / 2
        if int(mid) >= n or track[int(mid)] != 0:
            i += 1
            continue
        byte, ok = 0, True
        for b in range(8):
            p = int(mid + (b + 1) * BIT)
            if p >= n or track[p] is None:
                ok = False
                break
            byte |= track[p] << b
        stop = int(mid + 9 * BIT)
        if not ok or stop >= n or track[stop] != 1:
            break                           # tone ended or framing error: end of data
        data.append(byte)
        if maxbytes and len(data) >= maxbytes:
            break
        i = stop
    return bytes(data)

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('tape'); ap.add_argument('out')
    ap.add_argument('--max', type=int, default=None)
    a = ap.parse_args()
    data = decode(tone_track(load(a.tape)), a.max)
    open(a.out, 'wb').write(data)
    print(f'{a.out}: {len(data)} bytes')

if __name__ == '__main__':
    main()
