#!/bin/sh
# Run a tb script in MAME (driver d6800) and print the text frames.
cd "$(dirname "$0")"
D6800_SCRIPT="$1" /opt/homebrew/bin/mame d6800 -rompath ../ref/mame_roms \
  -video none -sound none -nothrottle -skip_gameinfo -window -noreadconfig \
  -autoboot_script mame_tb.lua 2>/dev/null | grep -vE '^(Average speed|$)'
