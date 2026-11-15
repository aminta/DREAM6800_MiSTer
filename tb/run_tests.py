#!/usr/bin/env python3
"""F1 tests: HDL (d6800_tb) against MAME (d6800) and against fixed expectations."""
import subprocess, sys, re, os
os.chdir(os.path.dirname(os.path.abspath(__file__)))

def run(cmd, script):
    return subprocess.run([cmd, script], capture_output=True, text=True).stdout

def frames(out):
    res, cur = [], None
    for l in out.splitlines():
        if l.startswith('==='): cur = []; res.append(cur)
        elif cur is not None and l and l[0] in '.#': cur.append(l)
    return res

def mems(out):
    return {m.group(1): bytes.fromhex(m.group(2)) for m in re.finditer(r'^mem (\w+): ?([0-9A-F ]*)$', out, re.M)} if False else \
           [(a, bytes.fromhex(d)) for a, d in re.findall(r'^mem (\w+):((?: [0-9A-F]{2})*)\s*$', out, re.M)]

def stats(out):
    return [tuple(map(int, s)) for s in re.findall(r'cpu_cycles (\d+) active (\d+) spk_toggles (\d+) rtc (\d+)', out)]

def pxdiff(a, b):
    return sum(x != y for ra, rb in zip(a, b) for x, y in zip(ra, rb))

results = []
def check(name, ok, info=''):
    results.append(ok)
    print(f"{'PASS' if ok else 'FAIL'}  {name}  {info}")

only = sys.argv[1:]
def want(t): return not only or t in only

if want('t1'):
    h, m = run('./d6800_tb', 'tests/t1_boot.txt'), run('./mame_run.sh', 'tests/t1_boot.txt')
    fh, fm = frames(h), frames(m)
    check('T1 boot screen = MAME', fh[0] == fm[0])
    check('T2 address C000 = MAME', fh[1] == fm[1])
    t = [d[0] for a, d in mems(h)]
    check('T7 RTC 50 Hz', (t[0] - t[1]) & 255 == 50, f'TIME {t[0]:02X} -> {t[1]:02X} in 50 frames')
    s = stats(h)[0]
    check('T2 bleep 2400 Hz', 90 <= s[2] <= 100, f'{s[2]} speaker edges in one frame (2400 Hz = 96)')
    check('T1 DMA halt 128/312 lines', s[0] == 19968 and s[1] == 11776, f'{s[1]}/{s[0]} active cycles')

if want('t3'):
    h, m = run('./d6800_tb', 'tests/t3_stop.txt'), run('./mame_run.sh', 'tests/t3_stop.txt')
    check('T3 memory modify + run F000 = MAME', frames(h) == frames(m) and mems(h) == mems(m))

if want('t5'):
    h, m = run('./d6800_tb', 'tests/t5_invaders.txt'), run('./mame_run.sh', 'tests/t5_invaders.txt')
    d = [pxdiff(a, b) for a, b in zip(frames(h), frames(m))]
    check('T5 Dream Invaders ~ MAME', len(d) == 4 and max(d) <= 40, f'pixel differences {d} (capture timing)')

if want('t6'):
    h, m = run('./d6800_tb', 'tests/t6_speed.txt'), run('./mame_run.sh', 'tests/t6_speed.txt')
    bcd = lambda b: b[0]*100 + b[1]*10 + b[2]
    th, tm = 255 - bcd(mems(h)[0][1]), 255 - bcd(mems(m)[0][1])
    check('T6 CHIP-8 speed vs MAME', abs(th - tm) <= 1, f'{th} vs {tm} RTC ticks for 3072 loops')
    tt = 255 - bcd(mems(run('./d6800_tb', 'tests/t6t_turbo.txt'))[0][1])
    check('T6t Turbo: same loop in ~59 % of the time', abs(tt / th - 11776 / 19968) < 0.03, f'{tt} vs {th} ticks')

if want('t8'):
    h = run('./d6800_tb', 'tests/t8_tape.txt')
    mm = mems(h)
    check('T8 tape save + reload', mm[0][1] == mm[1][1] and mm[2][1] == mm[3][1])
    s = stats(h)[0]
    f = frames(h)[0]
    check('T9 DMA off: black screen, CPU 1 MHz', s[1] == 19968 and all(set(r) == {'.'} for r in f), f'{s[1]} active cycles')

if want('t8b'):
    h = run('./d6800_tb', 'tests/t8b_bauer_tape.txt')
    got = mems(h)[0][1]
    ref = open('../ref/invaders/invaders_code.bin', 'rb').read()
    check("T8b Bauer's Invaders tape (MP3)", got == ref, f'{len(got)} bytes')

if want('t8c'):   # MiSTer ADC: line level (gain 8, ~0.9 V peak) and a weak signal (gain 2, ~0.22 V; at 0.11 V cycles miss the 64 mV threshold)
    ref = open('../ref/invaders/invaders_code.bin', 'rb').read()
    for g in (8, 2):
        got = mems(run('./d6800_tb', f'tests/t8c_adc_g{g}.txt'))[0][1]
        check(f"T8c Invaders tape via ADC model, gain {g}", got == ref,
              f'{sum(a == b for a, b in zip(got, ref))}/{len(ref)} bytes right')

if want('t10'):   # Bauer's joystick: service routine of DREAMER 3, stick at the corners and centre
    mm = mems(run('./d6800_tb', 'tests/t10_joystick.txt'))
    got = [tuple(m[1]) for m in mm]
    check('T10 Bauer joystick: VC/VD at corners and centre',
          got[0] == (0, 0) and got[1] == (0x3F, 0x1F) and abs(got[2][0] - 32) <= 2 and abs(got[2][1] - 16) <= 1,
          ' '.join('%02X/%02X' % g for g in got))

print(f"{sum(results)}/{len(results)} passed")
sys.exit(0 if all(results) else 1)
