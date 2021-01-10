# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

WX_GTK_VER="3.0-gtk3"
CMAKE_MIN_VERSION=3.2.2

inherit eutils cmake-utils xdg-utils ninja-utils wxwidgets

DESCRIPTION="Linux port of FAR Manager v2"
HOMEPAGE="https://github.com/elfmz/far2l"

if [[ "${PV}" == "9999" ]] ; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/elfmz/far2l"
	EGIT_BRANCH="master"
else
	MY_PV="${PV:4:5}-${PV:15:2}sep${PV:11:2}"
	MY_P="${PN}-${MY_PV}"
	S="${WORKDIR}/${MY_P}"
	SRC_URI="https://github.com/elfmz/far2l/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="+ssl libressl sftp samba nfs webdav +archive +wxwidgets python"

RDEPEND="sys-apps/gawk
	sys-devel/m4
	dev-libs/xerces-c
	dev-libs/spdlog
	app-i18n/uchardet
	wxwidgets? ( x11-libs/wxGTK:${WX_GTK_VER} )
	ssl? (
		!libressl? ( dev-libs/openssl )
		libressl? ( dev-libs/libressl )
	)
	sftp? ( net-libs/libssh )
	samba? ( net-fs/samba )
	nfs? ( net-fs/libnfs )
	webdav? ( net-libs/neon )
	archive? (
		dev-libs/libpcre2
		app-arch/libarchive )
	python? ( dev-python/virtualenv )"

DEPEND="${RDEPEND}"

DOCS=( README.md )

src_prepare() {
	sed -e "s:execute_process(COMMAND ln -sf \../../bin/far2l \${CMAKE_INSTALL_PREFIX}/lib/far2l/far2l_askpass)::" -i "${S}"/CMakeLists.txt
	sed -e "s:execute_process(COMMAND ln -sf \../../bin/far2l \${CMAKE_INSTALL_PREFIX}/lib/far2l/far2l_sudoapp)::" -i "${S}"/CMakeLists.txt
	sed -e "s:execute_process(COMMAND rm -f \${CMAKE_INSTALL_PREFIX}/lib/far2l/Plugins/objinfo/plug/objinfo.far-plug-mb)::" -i "${S}"/CMakeLists.txt
	sed -e "s:execute_process(COMMAND rm -f \${CMAKE_INSTALL_PREFIX}/lib/far2l/Plugins/farftp/plug/farftp.far-plug-mb && echo Removed existing farftp plugin)::" -i "${S}"/CMakeLists.txt
	sed -e "s:execute_process(COMMAND rm -f \${CMAKE_INSTALL_PREFIX}/lib/far2l/Plugins/python/plug/python.far-plug-wide && echo Removed existing python plugin)::" -i "${S}"/CMakeLists.txt
	cmake-utils_src_prepare
	default
}

pkg_setup() {
	if use wxwidgets; then
		setup-wxwidgets
	fi
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
		-DCMAKE_BUILD_TYPE=Release
	)

	if use wxwidgets; then
		mycmakeargs+=( -DUSEWX=yes )
	else
		mycmakeargs+=( -DUSEWX=no )
	fi

	if use python; then
		mycmakeargs+=( -DPYTHON=yes )
	else
		mycmakeargs+=( -DPYTHON=no )
	fi

	cmake-utils_src_configure
}

src_install(){
	cmake-utils_src_install
	einstalldocs
	dosym "../../bin/${PN}" "${EPREFIX}/usr/$(get_libdir)/${PN}/${PN}_askpass"
	dosym "../../bin/${PN}" "${EPREFIX}/usr/$(get_libdir)/${PN}/${PN}_sudoapp"
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
