# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="Utility to make modifier keys send custom key events when pressed on their own"
HOMEPAGE="https://github.com/alols/xcape"
SRC_URI="https://github.com/alols/xcape/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"

RDEPEND="x11-libs/libX11
	x11-libs/libXtst"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	default

	# Fix path to man and to pkg-config
	sed -i \
		-e '/MANDIR/s:local:share:' \
		-e 's/pkg-config/${PKG_CONFIG}/' \
		Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)" PKG_CONFIG="$(tc-getPKG_CONFIG)"
}

src_install() {
	emake PKG_CONFIG="$(tc-getPKG_CONFIG)" \
		DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
}
