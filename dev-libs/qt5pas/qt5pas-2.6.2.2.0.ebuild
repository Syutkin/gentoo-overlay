# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils

LAZ_COMMIT="4d49533f10195fc785940bb36693367c1a8e6ce2"
LAZ_DIRECTORY="lcl/interfaces/qt5/cbindings"
LAZ_UNPACKED_DIR="lazarus-${LAZ_COMMIT}-${LAZ_DIRECTORY//\//-}"

DESCRIPTION="Free Pascal Qt5 bindings library updated by lazarus IDE."
HOMEPAGE="https://www.lazarus-ide.org/"
SRC_URI="https://gitlab.com/freepascal.org/lazarus/lazarus/-/archive/${LAZ_COMMIT}/lazarus-main.tar.gz?path=${LAZ_DIRECTORY} -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="5"
RESTRICT="mirror"

KEYWORDS="~amd64 ~x86"

DEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtprintsupport:5
	dev-qt/qtnetwork:5
	dev-qt/qtx11extras:5"

#S="${WORKDIR}/lazarus/lcl/interfaces/qt5/cbindings"
S=${WORKDIR}/${LAZ_UNPACKED_DIR}/${LAZ_DIRECTORY}

#src_unpack() {
#	default
#	mv "${WORKDIR}/${LAZ_UNPACKED_DIR}/${LAZ_DIRECTORY}" "${WORKDIR}/${P}"
#}

src_configure(){
	eqmake5 "QT += x11extras" Qt5Pas.pro || die
}

src_install(){
	emake INSTALL_ROOT="${D}" install
}
