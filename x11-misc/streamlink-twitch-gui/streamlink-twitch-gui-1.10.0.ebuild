# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils

DESCRIPTION="A multi platform Twitch.tv browser for Streamlink"

HOMEPAGE="https://github.com/streamlink/streamlink-twitch-gui"

SRC_URI="https://github.com/streamlink/streamlink-twitch-gui/releases/download/v${PV}/${PN}-v${PV}-linux64.tar.gz"
RESTRICT="mirror"
KEYWORDS="~amd64"

SLOT="0"
LICENSE="hammer-and-chisel"
RDEPEND=""
DEPEND="${RDEPEND}
	>=net-misc/streamlink-1.4.0
	dev-libs/nss
	gnome-base/gconf
	media-libs/alsa-lib
	media-libs/libpng
	net-libs/gnutls
	sys-libs/zlib
	x11-libs/gtk+
	x11-libs/libnotify
	x11-libs/libxcb
	x11-libs/libXtst
	"

S=${WORKDIR}/${PN}

src_install() {
	dodir /usr/share
	rsync -a "${S}" "${ED%/}"/usr/share || die "Unable to copy files!"

	dosym ../share/streamlink-twitch-gui/streamlink-twitch-gui /usr/bin/streamlink-twitch-gui
}

pkg_postinst() {
	/usr/share/streamlink-twitch-gui/add-menuitem.sh	
}

pkg_prerm() {
	/usr/share/streamlink-twitch-gui/remove-menuitem.sh
}
