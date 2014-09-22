local fs = require "nixio.fs"
local util = require "nixio.util"

local running=(luci.sys.call("pidof chinadns > /dev/null") == 0)
if running then	
	m = Map("chinadns", translate("ChinaDNS"), translate("ChinaDNS is running"))
else
	m = Map("chinadns", translate("ChinaDNS"), translate("ChinaDNS is not running"))
end

s = m:section(TypedSection, "chinadns", translate("ChinaDNS"))
s.anonymous = true

enable = s:option(Flag, "enabled", translate("Enable"))
enable.default = false

dnsmasq_enable = s:option(Flag, "dnsmasq_enabled", translate("Dnsmasq"), translate("As dnsmasq default server"))
dnsmasq_enable.default = true

address = s:option(Value, "address", translate("Address"),translate("Default: 127.0.0.1"))
address.Default = "127.0.0.1"

port = s:option(Value, "port", translate("Port"),translate("Default: 53"))
port.datatype = "range(0,65535)"
port.Default = "1053"

dns_server = s:option(Value, "dns_server", translate("DNS Server"),translate("Default: 114.114.114.114,208.67.222.222,8.8.8.8"))
dns_server.Default = "114.114.114.114,8.8.4.4"

iplist_file = s:option(Value, "iplist_file", translate("Spurious IP File"),translate("Default: /etc/ipset/spurious"))
iplist_file.Default = "/etc/ipset/spurious"

return m
