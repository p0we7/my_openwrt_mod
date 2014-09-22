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

dnsmasq_enable = s:option(Flag, "dnsmasq_enabled", translate("Dnsmasq Server"))
dnsmasq_enable.default = true

address = s:option(Value, "address", translate("Address"),translate("Default: 0.0.0.0"))
address.Default = "0.0.0.0"

port = s:option(Value, "port", translate("Port"),translate("Default: 53"))
port.datatype = "range(0,65535)"
port.Default = "5353"

dns_server = s:option(Value, "dns_server", translate("DNS Server"),translate("Default: 114.114.114.114,208.67.222.222,8.8.8.8"))
dns_server.Default = "114.114.114.114,208.67.222.222,8.8.8.8"

iplist_file = s:option(TextValue, "sourious_ip", "Spurious IP", translate("/etc/ipset/spurious"))
iplist_file.template = "cbi/tvalue"
iplist_file.size = 30
iplist_file.rows = 10
iplist_file.wrap = "off"

function iplist_file.cfgvalue(self, section)
	return fs.readfile("/etc/ipset/spurious") or ""
end
function iplist_file.write(self, section, value)
	if value then
		value = value:gsub("\r\n?", "\n")
		fs.writefile("/tmp/spurious", value)
		fs.mkdir("/etc/ipset")
		if (fs.access("/etc/ipset/spurious") ~= true or luci.sys.call("cmp -s /tmp/spurious /etc/ipset/spurious") == 1) then
			fs.writefile("/etc/ipset/spurious", value)
		end
		fs.remove("/tmp/spurious")
	end
end

update_chnroute_file = s:option(Button, "_button", "China IP", "/etc/ipset/cdn")
update_chnroute_file.inputtitle = translate("Update")
update_chnroute_file.inputstyle = "apply"
function update_chnroute_file.write(self, section, value)
        update_chnroute_file.inputtitle = translate("Updating...")
        luci.sys.exec("/etc/init.d/chinadns start update_chnroute_file")
        update_chnroute_file.inputtitle = translate("Update")
end

return m

