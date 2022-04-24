# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

DESCRIPTION="The free app that makes your Internet safer"
HOMEPAGE="https://cloudflarewarp.com/"
SRC_URI="https://pkg.cloudflareclient.com/uploads/cloudflare_warp_2021_8_1_1_amd64_7c41aefd34.deb"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

#src_unpack() {
#	unpack_deb ${P}
#}

src_install() {
#	cp -a <path>/* "${D}" || die
	dodir /usr/share
	rsync -a "${S}" "${ED%/}"/usr/share || die "Unable to copy files!"

}

#src_install() {
#	dodoc FAQ NEWS README
#}
