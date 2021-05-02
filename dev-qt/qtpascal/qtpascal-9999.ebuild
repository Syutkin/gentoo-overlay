# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils subversion

DESCRIPTION="Qt5 bindings to free pascal"
HOMEPAGE="https://www.lazarus-ide.org/"
ESVN_REPO_URI="https://svn.freepascal.org/svn/lazarus/trunk/lcl/interfaces/qt5/cbindings"

LICENSE="GPL-2"
SLOT="5"

KEYWORDS=""

DEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtprintsupport:5
	dev-qt/qtnetwork:5
	dev-qt/qtx11extras:5"

src_prepare(){
	eapply_user
	eqmake5 Qt5Pas.pro || die
}

src_install(){
	dolib.so libQt5Pas*
}
