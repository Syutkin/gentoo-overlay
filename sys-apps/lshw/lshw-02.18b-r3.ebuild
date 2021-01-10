# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PLOCALES='fr'

inherit flag-o-matic toolchain-funcs l10n desktop xdg-utils

MAJ_PV=$(ver_cut 1-2)
MIN_PV=$(ver_cut 3)

MY_P="$PN-${MIN_PV^^}.$MAJ_PV"
DESCRIPTION="Hardware Lister"
HOMEPAGE="https://www.ezix.org/project/wiki/HardwareLiSter"
SRC_URI="https://www.ezix.org/software/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm ~arm64 ~mips ~ppc ~x86"
IUSE="gtk sqlite static"

REQUIRED_USE="static? ( !gtk )"

RDEPEND="gtk? ( x11-libs/gtk+:2 )
	sqlite? ( dev-db/sqlite:3 )"
DEPEND="${RDEPEND}
	gtk? ( virtual/pkgconfig )
	sqlite? ( virtual/pkgconfig )"
RDEPEND="${RDEPEND}
	sys-apps/hwids"

S="${WORKDIR}/${MY_P}"

PATCHES=(
	"${FILESDIR}/${PN}-02.18b-gentoo.patch"
	"${FILESDIR}/${PN}-02.18b-gettext-array.patch"
	"${FILESDIR}/${PN}-02.18b-sgx.patch"
	"${FILESDIR}/${PN}-02.18b-fixes.patch"
)

src_prepare() {
	default
	l10n_find_plocales_changes "src/po" "" ".po" || die
	sed -i \
		-e "/^LANGUAGES =/ s/=.*/= $(l10n_get_locales)/" \
		src/po/Makefile || die
	sed -i \
		-e 's:\<pkg-config\>:${PKG_CONFIG}:' \
		src/Makefile src/gui/Makefile || die
}

src_compile() {
	tc-export CC CXX AR PKG_CONFIG
	use static && append-ldflags -static

	# Need two sep make statements to avoid parallel build issues. #588174
	local sqlite=$(usex sqlite 1 0)
	emake SQLITE=${sqlite} all
	use gtk && emake SQLITE=${sqlite} gui
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install $(usex gtk 'install-gui' '')
	dodoc README.md docs/*
	if use gtk ; then
		newicon -s scalable src/gui/artwork/logo.svg gtk-lshw.svg
		make_desktop_entry \
			"${EPREFIX}"/usr/sbin/gtk-lshw \
			"${DESCRIPTION}"
	fi
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
