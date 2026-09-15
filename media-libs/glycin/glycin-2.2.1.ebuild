# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	glycin@4.0.0
	glycin-common@2.0.0
	glycin-utils@5.0.1
"
# These should be in the gentoo crate dist
CRATES+="
	async-io@2.6.0
	bytemuck@1.25.2
	cairo-rs@0.22.0
	exr@1.74.2
	four-cc@0.4.0
	gdk4@0.11.4
	gio@0.22.8
	gio-sys@0.22.8
	gio-unix@0.22.8
	glib@0.22.8
	glib-sys@0.22.8
	gobject-sys@0.22.6
	gufo@0.5.0
	gufo-exif@0.5.0
	gufo-jpeg@0.5.1
	gufo-common@2.0.0
	gufo-svg@0.5.0
	hayro-jpeg2000@0.3.5
	image@0.25.10
	image-extras@0.1.1
	jpeg-encoder@0.7.1
	jpegxl-rs@0.14.0+libjxl-0.11.2
	jpegxl-sys@0.12.1+libjxl-0.11.2
	libheif-rs@2.7.0
	libc@0.2.189
	libglycin-gtk4-rebind@0.2.0
	libglycin-gtk4-rebind-sys@0.2.0
	libglycin-rebind@0.2.0
	libglycin-rebind-sys@0.2.0
	libopenraw@0.4.0-alpha.12
	librsvg-rebind@0.3.0
	log@0.4.33
	moxcms@0.8.1
	png@0.18.1
	safe-transmute@0.11.3
	system-deps@7.0.8
	tiff@0.11.3
	tracing-subscriber@0.3.23
	zerocopy@0.8.55
	zune-jpeg@0.5.15
"
RUST_MIN_VER="1.92"

inherit cargo gnome.org meson vala

DESCRIPTION="Sandboxed and extendable image loading library"
HOMEPAGE="https://gnome.pages.gitlab.gnome.org/glycin"
SRC_URI+=" https://github.com/gentoo-crate-dist/glycin/releases/download/2.2.1/${PN}-2.2.1.tar.xz ${CARGO_CRATE_URIS}"

# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD GPL-3+ IJG ISC
	LGPL-3+ MIT Unicode-3.0
	|| ( LGPL-2.1+ MPL-2.0 )
"
SLOT="2"
KEYWORDS="~amd64 ~arm ~arm64 ~riscv ~x86"
IUSE="doc gtk +introspection vala test"
REQUIRED_USE="
	doc? ( introspection )
	gtk? ( introspection )
	vala? ( introspection )
"
RESTRICT="!test? ( test )"

DEPEND="
	>=media-libs/lcms-2.12:2
	>=dev-libs/glib-2.60:2
	>=sys-libs/libseccomp-2.5.0
	>=media-libs/fontconfig-2.13.0:1.0
	media-libs/glycin-loaders:2
	introspection? ( dev-libs/gobject-introspection )
	gtk? ( >=gui-libs/gtk-4.16.0:4 )
"

RDEPEND="${DEPEND}
	sys-apps/bubblewrap
"

BDEPEND="
	doc? ( dev-util/gi-docgen )
	vala? ( $(vala_depend) )
	virtual/pkgconfig
"

QA_FLAGS_IGNORED="
	usr/bin/${PN}-thumbnailer
	usr/lib.*/libglycin-2.so.0
	usr/lib.*/libglycin-gtk4-2.so.0
"

src_prepare() {
	default
	use vala && vala_setup
}

src_configure() {
	local emesonargs=(
		-Dlibglycin=true
		$(meson_use vala vapi)
		-Dglycin-loaders=false
		$(meson_use introspection)
		-Dglycin-thumbnailer=true
		$(meson_use gtk libglycin-gtk4)
		$(meson_use doc capi_docs)
		-Dtests=$(usex test true false)
		# required if glycin-loaders is installed seperately
		-Dtest_skip_install=true
	)

	meson_src_configure
	ln -s "${CARGO_HOME}" "${BUILD_DIR}/cargo-home" || die
}

src_install() {
	meson_src_install
	if use doc; then
		mkdir -p "${ED}"/usr/share/gtk-doc/html/ || die
		mv "${ED}"/usr/share/doc/libglycin{-2,-gtk4-2} "${ED}"/usr/share/gtk-doc/html/ || die
	fi
}
