#!/bin/sh
# Copy the DREAM6800 core to the MiSTer over SSH.
#   tools/deploy.sh [mister-host]      (default: $MISTER_HOST or MiSTer)
# Installs /media/fat/_Computer/DREAM6800_<date>.rbf (old DREAM6800_*.rbf removed).
# games/DREAM6800 (boot.rom and the programs) is not touched: see the README.
set -e
HOST=${1:-${MISTER_HOST:-MiSTer}}
TOP=$(cd "$(dirname "$0")/.." && pwd)
SSH="ssh -o BatchMode=yes root@$HOST"
RBF=$TOP/output_files/DREAM6800.rbf
[ -f "$RBF" ] || { echo "missing $RBF (run tools/build_core.sh)"; exit 1; }
DATE=$(date +%Y%m%d)
$SSH 'mkdir -p /media/fat/_Computer; rm -f /media/fat/_Computer/DREAM6800_*.rbf'
scp -q "$RBF" "root@$HOST:/media/fat/_Computer/DREAM6800_$DATE.rbf"
echo "core: /media/fat/_Computer/DREAM6800_$DATE.rbf"
