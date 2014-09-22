#
# Copyright (C) 2010-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-chinadns
PKG_VERSION:=1.0
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-chinadns
  SECTION:=LuCI
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=LuCI Support for chinadns
  DEPENDS:=+libc +ChinaDNS-C
  PKGARCH:=all
endef

define Package/luci-app-chinadns/description
LuCI Support for chinadns
endef

define Build/Compile
endef

define Package/luci-app-chinadns/install
	$(CP) ./files/* $(1)
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./chinadns.init $(1)/etc/init.d/chinadns
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./chinadns.conf $(1)/etc/config/chinadns
endef

define Package/luci-app-chinadns/postinst
#!/bin/sh
[ -n "${IPKG_INSTROOT}" ] || {
	( . /etc/uci-defaults/luci-chinadns ) && rm -f /etc/uci-defaults/luci-chinadns
	chmod 755 /etc/init.d/chinadns >/dev/null 2>&1
	/etc/init.d/chinadns enable >/dev/null 2>&1
	exit 0
}
endef

define Package/luci-app-chinadns/conffiles
  /etc/config/chinadns
  /etc/ipset/spurious
endef

$(eval $(call BuildPackage,luci-app-chinadns))
