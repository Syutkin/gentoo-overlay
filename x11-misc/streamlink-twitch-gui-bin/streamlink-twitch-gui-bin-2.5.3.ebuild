# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/-bin/}"

DESCRIPTION="A multi platform Twitch.tv browser for Streamlink"
HOMEPAGE="https://streamlink.github.io/streamlink-twitch-gui/"
SRC_URI="https://github.com/streamlink/${MY_PN}/releases/download/v${PV}/${MY_PN}-v${PV}-linux64.tar.gz -> ${PN}-${PV}.tar.gz"
S=${WORKDIR}/${PN}
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

DEPEND=">=net-misc/streamlink-6.0.0
	dev-libs/nss
	media-libs/alsa-lib
	x11-libs/gtk+:3
	x11-libs/libnotify
	x11-libs/libxcb
	"
RDEPEND="${DEPEND}"

QA_PREBUILT="
/usr/share/streamlink-twitch-gui-bin/streamlink-twitch-gui-bin
/usr/share/streamlink-twitch-gui-bin/lib/*.so"

src_unpack() {
	default
	mv "${WORKDIR}/${MY_PN}" "${WORKDIR}/${PN}" || die "Unable to rename source dir!"
}

src_prepare() {
	default
	sed -e "s:APP=\"streamlink-twitch-gui\":APP=\"streamlink-twitch-gui-bin\":" \
		-i "${S}"/add-menuitem.sh || die "Unable to sed 'add-menuitem.sh'!"
	sed -e "s:Name=Streamlink Twitch GUI:Name=Streamlink Twitch GUI (bin):" \
		-i "${S}"/add-menuitem.sh || die "Unable to sed 'add-menuitem.sh'!"
	sed -e "s:APP=\"streamlink-twitch-gui\":APP=\"streamlink-twitch-gui-bin\":" \
		-i "${S}"/remove-menuitem.sh || die "Unable to sed 'remove-menuitem.sh'!"
	mv "${S}/${MY_PN}" "${S}/${PN}" || die "Unable to rename file!"
}

src_install() {
	dodir /usr/share
	rsync -a "${S}" "${ED%}"/usr/share/ || die "Unable to copy files!"
	dosym ../share/"${PN}"/"${PN}" /usr/bin/"${PN}"
}

pkg_postinst() {
	/usr/share/"${PN}"/add-menuitem.sh
}

pkg_prerm() {
	/usr/share/"${PN}"/remove-menuitem.sh
}
