module("luci.controller.chinadns", package.seeall)

function index()
	
	if not nixio.fs.access("/etc/config/chinadns") then
		return
	end

	local page
	page = entry({"admin", "services", "chinadns"}, cbi("chinadns"), _("ChinaDNS"), 38)
	page.dependent = true
end
