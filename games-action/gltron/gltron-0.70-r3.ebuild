# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools desktop toolchain-funcs

DESCRIPTION="3d tron, just like the movie"
HOMEPAGE="https://gltron.sourceforge.net/"
SRC_URI="https://downloads.sourceforge.net/${PN}/${P}-source.tar.gz
	mirror://gentoo/${PN}.png"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

DEPEND="
	media-libs/libmikmod
	media-libs/libpng:=
	media-libs/libsdl[opengl,sound,video]
	media-libs/sdl-mixer[vorbis]
	media-libs/sdl-sound[vorbis,mikmod]
	media-libs/smpeg
	sys-libs/zlib
	virtual/opengl
	virtual/glu"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-configure.patch
	"${FILESDIR}"/${P}-debian.patch
	"${FILESDIR}"/${P}-gcc49.patch
	"${FILESDIR}"/${P}-prototypes.patch
	"${FILESDIR}"/${P}-gcc14.patch
	"${FILESDIR}"/${P}-automake.patch
)

src_prepare() {
	default

	sed -i \
		-e '/^gltron_LINK/s/$/ $(LDFLAGS)/' \
		Makefile.in || die

	eautoreconf
}

src_configure() {
	# warn/debug/profile just modify CFLAGS, they aren't
	# real options, so don't utilize USE flags here
	econf \
		--disable-warn \
		--disable-debug \
		--disable-profile
}

src_compile() {
	emake AR=$(tc-getAR)
}

src_install() {
	default

	doicon "${DISTDIR}"/${PN}.png
	make_desktop_entry ${PN} GLtron
}
