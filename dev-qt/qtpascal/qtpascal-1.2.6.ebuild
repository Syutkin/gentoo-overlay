# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils

LAZARUS_VERSION="2.0.12"

DESCRIPTION="Qt5 bindings to free pascal"
HOMEPAGE="https://www.lazarus-ide.org/"
SRC_URI="https://sourceforge.net/projects/lazarus/files/Lazarus%20Zip%20_%20GZip/Lazarus%20${LAZARUS_VERSION}/lazarus-${LAZARUS_VERSION}.tar.gz"
LICENSE="GPL-2"
SLOT="5"
RESTRICT="mirror"

KEYWORDS="~amd64 ~x86"

DEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtprintsupport:5
	dev-qt/qtnetwork:5
	dev-qt/qtx11extras:5"

S="${WORKDIR}/lazarus/lcl/interfaces/qt5/cbindings"

src_prepare(){
	eapply_user
	eqmake5 Qt5Pas.pro || die
}

src_install(){
	dolib.so libQt5Pas*
}
