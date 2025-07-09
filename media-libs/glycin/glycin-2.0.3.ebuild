# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# crates vendored upstream
CRATES="
	addr2line@0.24.2
	adler2@2.0.1
	ahash@0.8.12
	aho-corasick@1.1.3
	allocator-api2@0.2.21
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anyhow@1.0.99
	approx@0.5.1
	async-broadcast@0.7.2
	async-channel@2.5.0
	async-executor@1.13.3
	async-fs@2.1.3
	async-global-executor@3.1.0
	async-io@2.5.0
	async-lock@3.4.1
	async-process@2.4.0
	async-recursion@1.1.1
	async-signal@0.2.12
	async-task@4.7.1
	async-trait@0.1.89
	atomic-waker@1.1.2
	autocfg@1.5.0
	backtrace@0.3.75
	bit_field@0.10.3
	bitflags@1.3.2
	bitflags@2.9.3
	bitreader@0.3.11
	blocking@1.6.2
	bumpalo@3.19.0
	bytemuck@1.23.2
	byteorder-lite@0.1.0
	byteorder@1.5.0
	bytes@1.10.1
	cairo-rs@0.21.1
	cairo-sys-rs@0.21.1
	cc@1.2.34
	cfg-expr@0.18.0
	cfg-if@1.0.3
	cfg_aliases@0.2.1
	chrono@0.4.41
	color_quant@1.1.0
	concurrent-queue@2.5.0
	core-foundation-sys@0.8.7
	crc32fast@1.5.0
	crossbeam-deque@0.8.6
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.21
	crunchy@0.2.4
	darling@0.20.11
	darling_core@0.20.11
	darling_macro@0.20.11
	derive_builder@0.20.2
	derive_builder_core@0.20.2
	derive_builder_macro@0.20.2
	dlib@0.5.2
	dunce@1.0.5
	either@1.15.0
	encoding_rs@0.8.35
	endi@1.1.0
	enumflags2@0.7.12
	enumflags2_derive@0.7.12
	enumn@0.1.14
	env_filter@0.1.3
	env_logger@0.11.8
	equivalent@1.0.2
	errno@0.3.13
	event-listener-strategy@0.5.4
	event-listener@5.4.1
	exr@1.73.0
	fallible_collections@0.5.1
	fastrand@2.3.0
	fdeflate@0.3.7
	flate2@1.1.2
	fnv@1.0.7
	foreign-types-macros@0.2.3
	foreign-types-shared@0.3.1
	foreign-types@0.5.0
	four-cc@0.4.0
	futures-channel@0.3.31
	futures-core@0.3.31
	futures-executor@0.3.31
	futures-io@0.3.31
	futures-lite@2.6.1
	futures-macro@0.3.31
	futures-task@0.3.31
	futures-timer@3.0.3
	futures-util@0.3.31
	gdk-pixbuf-sys@0.21.1
	gdk-pixbuf@0.21.1
	gdk4-sys@0.10.0
	gdk4@0.10.0
	getopts@0.2.23
	getrandom@0.3.3
	gif@0.13.3
	gimli@0.31.1
	gio-sys@0.21.1
	gio@0.21.1
	glib-macros@0.21.0
	glib-sys@0.21.1
	glib@0.21.1
	glycin-common@1.0.0-rc
	glycin-utils@4.0.0-rc
	glycin@3.0.0-rc
	gobject-sys@0.21.1
	gufo-common@1.0.0
	gufo-exif@0.3.0
	gufo-jpeg@0.3.0
	gufo-png@0.3.0
	gufo-tiff@0.3.0
	gufo-webp@0.3.0
	gufo-xmp@0.3.0
	gufo@0.3.0
	half@2.6.0
	hashbrown@0.14.5
	hashbrown@0.15.5
	heck@0.5.0
	hermit-abi@0.5.2
	hex@0.4.3
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.63
	ident_case@1.0.1
	image-webp@0.2.4
	image@0.25.6
	indexmap@2.11.0
	io-uring@0.7.10
	itoa@1.0.15
	jiff-static@0.2.15
	jiff@0.2.15
	jobserver@0.1.34
	jpeg-decoder@0.3.2
	jpeg-encoder@0.6.1
	jpeg2k@0.10.1
	jpegxl-rs@0.11.2+libjxl-0.11.1
	jpegxl-sys@0.11.2+libjxl-0.11.1
	js-sys@0.3.77
	lazy_static@1.5.0
	lcms2-sys@4.0.6
	lcms2@6.1.1
	lebe@0.5.2
	libc@0.2.175
	libheif-rs@2.3.0
	libheif-sys@5.0.0+1.20.2
	libloading@0.8.8
	libopenraw@0.4.0-alpha.11
	librsvg-rebind-sys@0.2.1
	librsvg-rebind@0.2.1
	libseccomp-sys@0.3.0
	libseccomp@0.4.0
	linux-raw-sys@0.4.15
	linux-raw-sys@0.9.4
	log@0.4.27
	matchers@0.1.0
	matrixmultiply@0.3.10
	memchr@2.7.5
	memfd@0.6.4
	memmap2@0.9.8
	memoffset@0.9.1
	miniz_oxide@0.8.9
	mio@1.0.4
	multiversion-macros@0.8.0
	multiversion@0.8.0
	nalgebra-macros@0.2.2
	nalgebra@0.33.2
	nix@0.30.1
	nu-ansi-term@0.46.0
	num-bigint@0.4.6
	num-complex@0.4.6
	num-integer@0.1.46
	num-rational@0.4.2
	num-traits@0.2.19
	num_enum@0.7.4
	num_enum_derive@0.7.4
	object@0.36.7
	once_cell@1.21.3
	openjp2@0.6.1
	ordered-stream@0.2.0
	overload@0.1.1
	pango-sys@0.21.1
	pango@0.21.1
	parking@2.2.1
	paste@1.0.15
	pin-project-lite@0.2.16
	pin-utils@0.1.0
	piper@0.2.4
	pkg-config@0.3.32
	png@0.17.16
	polling@3.10.0
	portable-atomic-util@0.2.4
	portable-atomic@1.11.1
	ppv-lite86@0.2.21
	proc-macro-crate@3.3.0
	proc-macro2@1.0.101
	qoi@0.4.1
	quick-error@2.0.1
	quote@1.0.40
	r-efi@5.3.0
	rand@0.9.2
	rand_chacha@0.9.0
	rand_core@0.9.3
	rawpointer@0.2.1
	rayon-core@1.13.0
	rayon@1.11.0
	regex-automata@0.1.10
	regex-automata@0.4.10
	regex-syntax@0.6.29
	regex-syntax@0.8.6
	regex@1.11.2
	rmp-serde@1.3.0
	rmp@0.8.14
	rustc-demangle@0.1.26
	rustix@0.38.44
	rustix@1.0.8
	rustversion@1.0.22
	ryu@1.0.20
	safe-transmute@0.11.3
	safe_arch@0.7.4
	same-file@1.0.6
	serde@1.0.219
	serde_derive@1.0.219
	serde_repr@0.1.20
	serde_spanned@0.6.9
	serde_yaml_ng@0.10.0
	sharded-slab@0.1.7
	shlex@1.3.0
	signal-hook-registry@1.4.6
	simba@0.9.0
	simd-adler32@0.3.7
	simple_logger@5.0.0
	slab@0.4.11
	smallvec@1.15.1
	socket2@0.6.0
	sprintf@0.1.4
	static_assertions@1.1.0
	strsim@0.11.1
	syn@2.0.106
	system-deps@7.0.5
	target-features@0.1.6
	target-lexicon@0.13.2
	tempfile@3.21.0
	thiserror-impl@1.0.69
	thiserror-impl@2.0.16
	thiserror@1.0.69
	thiserror@2.0.16
	thread_local@1.1.9
	tiff@0.9.1
	tokio-stream@0.1.17
	tokio@1.47.1
	toml@0.8.23
	toml_datetime@0.6.11
	toml_edit@0.22.27
	tracing-attributes@0.1.30
	tracing-core@0.1.34
	tracing-log@0.2.0
	tracing-subscriber@0.3.19
	tracing@0.1.41
	typenum@1.18.0
	uds_windows@1.1.0
	unicode-ident@1.0.18
	unicode-width@0.2.1
	unsafe-libyaml@0.2.11
	valuable@0.1.1
	vcpkg@0.2.15
	version-compare@0.2.0
	version_check@0.9.5
	walkdir@2.5.0
	wasi@0.11.1+wasi-snapshot-preview1
	wasi@0.14.2+wasi-0.2.4
	wasm-bindgen-backend@0.2.100
	wasm-bindgen-macro-support@0.2.100
	wasm-bindgen-macro@0.2.100
	wasm-bindgen-shared@0.2.100
	wasm-bindgen@0.2.100
	weezl@0.1.10
	wide@0.7.33
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.10
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-core@0.61.2
	windows-implement@0.60.0
	windows-interface@0.59.1
	windows-link@0.1.3
	windows-result@0.3.4
	windows-strings@0.4.2
	windows-sys@0.48.0
	windows-sys@0.59.0
	windows-sys@0.60.2
	windows-targets@0.48.5
	windows-targets@0.52.6
	windows-targets@0.53.3
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_gnullvm@0.53.0
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.6
	windows_aarch64_msvc@0.53.0
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.6
	windows_i686_gnu@0.53.0
	windows_i686_gnullvm@0.52.6
	windows_i686_gnullvm@0.53.0
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.6
	windows_i686_msvc@0.53.0
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnu@0.53.0
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_gnullvm@0.53.0
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.6
	windows_x86_64_msvc@0.53.0
	winnow@0.7.13
	wit-bindgen-rt@0.39.0
	xml-rs@0.8.27
	yeslogic-fontconfig-sys@6.0.0
	zbus@5.10.0
	zbus_macros@5.10.0
	zbus_names@4.2.0
	zerocopy-derive@0.8.26
	zerocopy@0.8.26
	zune-core@0.4.12
	zune-inflate@0.2.54
	zune-jpeg@0.4.20
	zvariant@5.7.0
	zvariant_derive@5.7.0
	zvariant_utils@3.2.1
"

RUST_MIN_VERSION=1.90.0

inherit cargo meson

MY_P=glycin-${PV/_/.}
DESCRIPTION="Loaders for glycin clients (glycin crate or libglycin)"
HOMEPAGE="https://gitlab.gnome.org/GNOME/glycin/"
SRC_URI="https://download.gnome.org/sources/glycin/$(ver_cut 1-2)/${MY_P}.tar.xz"
#S=${WORKDIR}/glycin-2.0.rc

LICENSE="|| ( LGPL-2.1+ MPL-2.0 )"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD GPL-3+ ISC LGPL-3+
	MIT Unicode-3.0
	|| ( LGPL-2.1+ MPL-2.0 )
"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="heif jpegxl svg test"
REQUIRED_USE="test? ( heif jpegxl )"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-libs/glib-2.60:2
	>=sys-libs/libseccomp-2.5.0
	heif? ( >=media-libs/libheif-1.17.0:= )
	jpegxl? ( >=media-libs/libjxl-0.10.0:= )
	svg? (
		>=gnome-base/librsvg-2.52.0:2
		>=x11-libs/cairo-1.17.0
	)
"
DEPEND="
	${RDEPEND}
	dev-lang/vala[valadoc]
	test? (
		>=gui-libs/gtk-4.16.0:4
		>=media-libs/lcms-2.14:2
	)
"
BDEPEND="
	test? (
		sys-apps/bubblewrap
		sys-apps/dbus
	)
"

ECARGO_VENDOR=${S}/vendor

QA_FLAGS_IGNORED="usr/libexec/glycin-loaders/.*"

src_prepare() {
	default
}

src_configure() {
	local formats=(
		$(usev heif glycin-heif)
		$(usev jpegxl glycin-jxl)
		$(usev svg glycin-svg)
		glycin-image-rs
	)
	local formats_s=${formats[*]}
	local emesonargs=(
		-Dprofile=$(usex debug dev release)
		-Dglycin-loaders=true
		-Dloaders="${formats_s// /,}"
		-Dtests=$(usex test true false)
		-Dlibglycin=true
	)

	meson_src_configure
	ln -s "${CARGO_HOME}" "${BUILD_DIR}/cargo-home" || die
}

src_test() {
	# tests write to /proc/*/uid_map
	# apparently, "addpredict /" in Portage breaks it
	local -x SANDBOX_ON=0
	meson_src_test
}
