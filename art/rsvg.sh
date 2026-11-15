#!/bin/sh
# rsvg-convert with only the fonts in art/fonts (fontconfig, not CoreText): rsvg.sh in.svg -o out.png
D=$(cd "$(dirname "$0")" && pwd)
FONTCONFIG_FILE="$D/fonts/fonts.conf" PANGOCAIRO_BACKEND=fontconfig exec rsvg-convert "$@"
