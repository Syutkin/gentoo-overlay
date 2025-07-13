# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg-utils

DESCRIPTION="ToneLib GFX - guitar effects processor"
HOMEPAGE="https://tonelib.net/gfx-overview.html"
SRC_URI="https://tonelib.vip/download/24-10-24/ToneLib-GFX-amd64.deb"
S=${WORKDIR}

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
IUSE="alsa jack"
RESTRICT="bindist mirror"

DEPEND="
	alsa? ( media-libs/alsa-lib )
	jack? ( virtual/jack )
"

QA_PREBUILT="
/usr/lib/vst/ToneLib-GFX.so
/usr/lib/vst3/ToneLib-GFX.vst3/Contents/x86_64-linux/ToneLib-GFX.so
/usr/bin/ToneLib-GFX"

src_unpack() {
	ar x "${DISTDIR}/${A}"
	tar -xf data.tar.xz
}

src_install() {
	sed -i -e 's/AudioEditing/X-AudioEditing/' usr/share/applications/ToneLib-GFX.desktop || die
	dodoc usr/share/doc/tonelib-gfx/copyright
	rm -rf usr/share/doc || die
	cp -r usr "${D}/" || die
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
