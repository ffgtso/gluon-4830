local site_i18n = i18n 'gluon-site'

local site = require 'gluon.site'
local sysconfig = require 'gluon.sysconfig'
local pretty_hostname = require 'pretty_hostname'

local uci = require("simple-uci").cursor()

local hostname = pretty_hostname.get(uci)
local contact = uci:get_first('gluon-node-info', 'owner', 'contact')

local util = require "gluon.util"
local ssid = site.wifi24.ap.ssid('4830.org')
local core_domain = uci:get("gluon", "core", "domain") or "n/a"
local communityname = string.gsub(util.exec(string.format("/lib/gluon/ffgt-geolocate/get_domain_name.sh %s", core_domain)),"\n", "") or "n/a"

local msg = site_i18n._translate('gluon-config-mode:reboot')
if not msg then return end

renderer.render_string(msg, {
	hostname = hostname,
	site = site,
	sysconfig = sysconfig,
	contact = contact,
	ssid = ssid,
	domain = core_domain,
	community = communityname,
})
