-- MAME reference runner: same script language as tb.cpp (subset).
-- Usage: D6800_SCRIPT=file mame d6800 -autoboot_script mame_tb.lua ...
-- Prints the video RAM (0100-01FF) as 64x32 text frames.
local script = os.getenv("D6800_SCRIPT")
local cmds = {}
for line in io.lines(script) do
  line = line:gsub("#.*", "")
  local w = {}
  for t in line:gmatch("%S+") do w[#w+1] = t end
  if #w > 0 then cmds[#cmds+1] = w end
end

local machine = manager.machine
local space = machine.devices[":maincpu"].spaces["program"]
local ports = machine.ioport.ports
local frame = 0
local keymap = {}
local names = {"0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"}
for i, n in ipairs(names) do
  local row = (i-1) // 4
  keymap[n] = ports[":X" .. row].fields[n]
end
keymap["*"] = ports[":SHIFT"].fields["FN"]
local kd, ku = 3, 6

local function dump(label)
  print(string.format("=== frame %d %s", frame, label or ""))
  for y = 0, 31 do
    local s = {}
    for xb = 0, 7 do
      local b = space:read_u8(0x100 + y*8 + xb)
      for bit = 7, 0, -1 do s[#s+1] = ((b >> bit) & 1) == 1 and "#" or "." end
    end
    print(table.concat(s))
  end
end

local function hex(s) return tonumber(s, 16) end

-- a queue of actions, each runs at frame boundaries
local co = coroutine.create(function()
  local function wait(n) for i = 1, n do coroutine.yield() end end
  for _, w in ipairs(cmds) do
    local c = w[1]
    if c == "run" then wait(tonumber(w[2]))
    elseif c == "keytime" then kd, ku = tonumber(w[2]), tonumber(w[3])
    elseif c == "keys" then
      for ch in w[2]:gmatch(".") do
        local f = keymap[ch:upper()]
        if f then f:set_value(1); wait(kd); f:clear_value(); wait(ku) end
      end
    elseif c == "hold" then
      local f = keymap[w[2]:upper()]; f:set_value(1); wait(tonumber(w[3])); f:clear_value()
    elseif c == "dump" then dump(table.concat(w, " ", 2))
    elseif c == "mem" then
      local a, n = hex(w[2]), tonumber(w[3])
      local s = {}
      for i = 0, n-1 do s[#s+1] = string.format("%02X", space:read_u8(a+i)) end
      print(string.format("mem %04X: %s", a, table.concat(s, " ")))
    elseif c == "poke" then
      local a = hex(w[2])
      for i = 3, #w do space:write_u8(a + i - 3, hex(w[i])) end
    elseif c == "load" then
      local a = hex(w[2]); local f = io.open(w[3], "rb"); local d = f:read("a"); f:close()
      for i = 1, #d do space:write_u8(a + i - 1, d:byte(i)) end
    elseif c == "boot" then
      machine.devices[":maincpu"].state["PC"].value = hex(w[2])
    elseif c == "reset" then
      local f = ports[":RESET"].fields["RST"]; f:set_value(1); wait(1); f:clear_value()
    end
    io.stdout:flush()
  end
  machine:exit()
end)

emu.register_frame_done(function()
  frame = frame + 1
  if coroutine.status(co) ~= "dead" then
    local ok, err = coroutine.resume(co)
    if not ok then print("lua error: " .. tostring(err)); machine:exit() end
  end
end)
