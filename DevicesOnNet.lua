#!/usr/bin/env lua

local function get_network_devices()
  local devices = {}
  for line in io.lines("/proc/net/arp") do
    local fields = {}
    for w in string.gmatch(line, "%w+") do
      table.insert(fields, w)
    end
    if fields[4] ~= "00:00:00:00:00:00" then
      table.insert(devices, {ip=fields[1], mac=fields[4]})
    end
  end
  return devices
end

for _, dev in ipairs(get_network_devices()) do
  print(dev.ip, dev.mac)
end
