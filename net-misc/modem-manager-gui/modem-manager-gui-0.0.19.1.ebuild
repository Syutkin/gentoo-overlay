# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit xdg-utils

DESCRIPTION="GUI for Modem Manager daemon."
HOMEPAGE="https://linuxonly.ru/page/modem-manager-gui"
SRC_URI="http://download.tuxfamily.org/gsf/source/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-3.4.0
	>=dev-libs/glib-2.32.1
	>=sys-libs/gdbm-1.10
	>=app-text/po4a-0.45
	>=dev-util/itstool-1.2.0
	>=dev-util/meson-0.37
	dev-libs/libappindicator
	app-text/gtkspell:3
	x11-libs/libnotify"
RDEPEND="${DEPEND}"

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
