#!/bin/sh
# Convert the VHDL blocks to Verilog for Verilator (GHDL in Docker).
cd "$(dirname "$0")/.."
docker run --rm --platform linux/amd64 -v "$PWD":/w -w /w hdlc/ghdl:yosys bash -c '
ghdl -a --std=08 -fsynopsys rtl/cpu68.vhd rtl/pia6821.vhd &&
ghdl --synth --std=08 -fsynopsys --out=verilog cpu68 > sim/gen/cpu68.v &&
ghdl --synth --std=08 -fsynopsys --out=verilog pia6821 > sim/gen/pia6821.v; rm -f *.cf' 2>&1 | grep -v Whide | grep -iE 'error' 
true
