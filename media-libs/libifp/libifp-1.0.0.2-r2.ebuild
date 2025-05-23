# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="General-purpose library for iRiver's iFP portable audio players"
HOMEPAGE="https://ifp-driver.sourceforge.net/libifp/"
SRC_URI="https://downloads.sourceforge.net/ifp-driver/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm64 ppc ppc64 x86"
IUSE="doc examples static-libs"

RDEPEND="virtual/libusb:0"
DEPEND="${RDEPEND}
	doc? ( >=app-text/doxygen-1.3.7 )
	elibc_musl? ( sys-libs/fts-standalone:= )"
BDEPEND="${DEPEND}
	virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/${P}-configure.patch"
	"${FILESDIR}/${P}-c23.patch"
)

src_prepare() {
	default

	eautoreconf
}

src_configure() {
	use doc || export have_doxygen=no
	use elibc_musl && append-ldflags -lfts # 713650
	econf \
		$(use_enable static-libs static) \
		$(use_enable examples) \
		--with-libusb \
		--without-kmodule
}

src_test() { :; } # hardware dependant wrt #318597

src_install() {
	emake DESTDIR="${D}" install

	find "${D}" -name '*.la' -exec rm -f {} + || die

	# clean /usr/bin after installation
	# by moving examples to examples dir
	if use examples; then
	    insinto /usr/share/${PN}/examples
	    doins "${S}"/examples/simple.c "${S}"/examples/ifpline.c
	    mv "${D}"/usr/bin/{simple,ifpline} "${D}"/usr/share/${PN}/examples || die
	else
	    rm -f "${D}"/usr/bin/{simple,ifpline} || die
	fi

	use doc && dodoc README ChangeLog TODO
}
