# DREAM 6800 Verilator testbench
VFLAGS = --cc --exe --build -O3 --x-assign fast --x-initial fast -Wno-fatal -Wno-lint -Wno-style \
         -MAKEFLAGS "OPT_FAST=-O2 -j8" \
         -GCPU_DIV=4 -GROM_FILE='"../rtl/chipos.hex"' --top-module dream6800 -Mdir obj_dir -o ../d6800_tb
SRC = ../sim/gen/cpu68.v ../sim/gen/pia6821.v ../rtl/dream6800.sv

d6800_tb: $(SRC) tb.cpp
	verilator $(VFLAGS) $(SRC) tb.cpp > verilator.log 2>&1 || (grep -E "%Error" verilator.log | head; false)

test: d6800_tb
	@./run_tests.py

clean:
	rm -rf obj_dir d6800_tb verilator.log

# Desk view (rtl/d6800_desk.sv): one frame as PPM, compared with art/desk_expect.png
desk_tb: ../rtl/d6800_desk.sv ../rtl/desk_assets.svh desk_tb.cpp
	verilator --cc --exe --build -O2 -Wno-fatal -Wno-lint -Wno-style -I../rtl \
	  -GTILES_FILE='"../rtl/desk_tiles.hex"' -GMAP_FILE='"../rtl/desk_map.hex"' \
	  --top-module d6800_desk -Mdir obj_desk -o ../desk_tb ../rtl/d6800_desk.sv desk_tb.cpp > verilator_desk.log 2>&1 || (grep -E "%Error" verilator_desk.log | head; false)

desk: desk_tb
	./desk_tb obj_desk/desk.ppm && ./desk_tb obj_desk/desk_ov.ppm 1
	python3 -c "from PIL import Image,ImageChops; a=Image.open('obj_desk/desk.ppm').convert('RGB'); b=Image.open('../art/desk_expect.png').convert('RGB'); d=ImageChops.difference(a,b).getbbox(); print('desk frame', 'MATCH' if d is None else 'DIFF %s'%(d,)); Image.open('obj_desk/desk_ov.ppm').save('../art/frame_desk_ov.png')"
