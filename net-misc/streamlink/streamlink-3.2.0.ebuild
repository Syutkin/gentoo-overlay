# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
PYTHON_REQ_USE='xml(+),threads(+)'
DISTUTILS_SINGLE_IMPL=1
inherit distutils-r1 ${GIT_ECLASS}

DESCRIPTION="CLI for extracting streams from websites to a video player of your choice"
HOMEPAGE="https://streamlink.github.io/"

SRC_URI="https://github.com/streamlink/${PN}/releases/download/${PV}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

LICENSE="BSD-2 Apache-2.0"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
	$(python_gen_cond_dep '
		>dev-python/requests-2.21.0[${PYTHON_USEDEP}]
		dev-python/isodate[${PYTHON_USEDEP}]
		dev-python/websocket-client[${PYTHON_USEDEP}]
		dev-python/pycountry[${PYTHON_USEDEP}]
		>=dev-python/pycryptodome-3.4.3[${PYTHON_USEDEP}]
	')
"
RDEPEND="${DEPEND}
	media-video/rtmpdump
	media-video/ffmpeg
"
BDEPEND="
	$(python_gen_cond_dep '
		test? (
			dev-python/mock[${PYTHON_USEDEP}]
			dev-python/requests-mock[${PYTHON_USEDEP}]
			dev-python/pytest[${PYTHON_USEDEP}]
			>=dev-python/freezegun-1.0.0[${PYTHON_USEDEP}]
		)
	')"

src_prepare() {
	distutils-r1_src_prepare
}

python_configure_all() {
	# Avoid iso-639, iso3166 dependencies since we use pycountry.
	export STREAMLINK_USE_PYCOUNTRY=1
}

python_test() {
	esetup.py test
}

python_install_all() {
	distutils-r1_python_install_all
}
