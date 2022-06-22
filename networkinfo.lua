local function getNetworks()
    local networks = {}
    for line in io.lines("/proc/net/wireless") do
        local ssid, signal, noise, nwid = string.match(line, "^%s*(%w+).-(%d+)%s+(%d+)%s+(%x+)")
        if ssid and signal and noise and nwid then
            table.insert(networks, {ssid=ssid, signal=signal, noise=noise, nwid=nwid})
        end
    end
    return networks
end
 
local function getNetworkDetails(network)
    local details = {}
    local iwconfig = io.popen("iwconfig " .. network.ssid)
    for line in iwconfig:lines() do
        local key, val = string.match(line, "^%s*(%w+)%s*:%s*(.+)$")
        if key and val then
            details[key] = val
        end
    end
    return details
end
 
local function printNetworkDetails(network, details)
    print(network.ssid .. ":")
    for key, val in pairs(details) do
        print(key .. ": " .. val)
    end
    print()
end
 
for _, network in ipairs(getNetworks()) do
    printNetworkDetails(network, getNetworkDetails(network))
end
