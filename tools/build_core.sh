#!/bin/sh
# Compile the DREAM6800 FPGA core with Quartus 17.0.2 Lite in Docker (x86 image,
# runs under Rosetta on Apple Silicon).  Output: core/output_files/DREAM6800.rbf
#
# Synthesis (quartus_map) runs on one processor: in parallel mode it hangs
# under Rosetta.  The fitter, the slowest step, runs on 8 processors.
set -e
cd "$(dirname "$0")/.."
docker run --rm --platform linux/amd64 -v "$PWD":/build -w /build \
    --entrypoint bash theypsilon/quartus-lite-c5:17.0.2-heavy -c '
set -e
t0=$(date +%s)
printf "\`define BUILD_DATE \"%s\"" "$(date +%y%m%d)" > build_id.v
: > build.log
quartus_map DREAM6800 -c DREAM6800 >> build.log 2>&1
quartus_fit --parallel=1 DREAM6800 -c DREAM6800 >> build.log 2>&1
quartus_asm DREAM6800 -c DREAM6800 >> build.log 2>&1
quartus_sta DREAM6800 -c DREAM6800 >> build.log 2>&1
echo "build time: $(( $(date +%s) - t0 ))s"'
grep -E "Worst-case setup slack|Error \(" build.log | head -3
ls -la output_files/DREAM6800.rbf
