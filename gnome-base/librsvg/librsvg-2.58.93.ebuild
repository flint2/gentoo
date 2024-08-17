# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..13} )

CRATES="
	adler@1.0.2
	aho-corasick@1.1.3
	aligned-vec@0.5.0
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anes@0.1.6
	anstream@0.6.14
	anstyle@1.0.7
	anstyle-parse@0.2.4
	anstyle-query@1.1.0
	anstyle-wincon@3.0.3
	anyhow@1.0.86
	approx@0.5.1
	arbitrary@1.3.2
	arg_enum_proc_macro@0.3.4
	arrayvec@0.7.4
	assert_cmd@2.0.14
	autocfg@1.3.0
	av1-grain@0.2.3
	avif-serialize@0.8.1
	bit-set@0.5.3
	bit-vec@0.6.3
	bitflags@1.3.2
	bitflags@2.6.0
	bitstream-io@2.5.0
	block@0.1.6
	block-buffer@0.10.4
	bstr@1.9.1
	built@0.7.4
	bumpalo@3.16.0
	bytemuck@1.16.1
	byteorder@1.5.0
	byteorder-lite@0.1.0
	cairo-rs@0.20.0
	cairo-sys-rs@0.20.0
	cast@0.3.0
	cc@1.1.5
	cfg-expr@0.15.8
	cfg-if@1.0.0
	chrono@0.4.38
	ciborium@0.2.2
	ciborium-io@0.2.2
	ciborium-ll@0.2.2
	clap@4.5.9
	clap_builder@4.5.9
	clap_complete@4.5.8
	clap_derive@4.5.8
	clap_lex@0.7.1
	color_quant@1.1.0
	colorchoice@1.0.1
	core-foundation-sys@0.8.6
	crc32fast@1.4.2
	criterion@0.5.1
	criterion-plot@0.5.0
	crossbeam-deque@0.8.5
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.20
	crunchy@0.2.2
	crypto-common@0.1.6
	cssparser@0.31.2
	cssparser-macros@0.6.1
	data-url@0.3.1
	deranged@0.3.11
	derive_more@0.99.18
	difflib@0.4.0
	digest@0.10.7
	dlib@0.5.2
	doc-comment@0.3.3
	dtoa@1.0.9
	dtoa-short@0.3.5
	either@1.13.0
	encoding_rs@0.8.34
	equivalent@1.0.1
	errno@0.3.9
	fastrand@2.1.0
	fdeflate@0.3.4
	flate2@1.0.30
	float-cmp@0.9.0
	fnv@1.0.7
	form_urlencoded@1.2.1
	futf@0.1.5
	futures-channel@0.3.30
	futures-core@0.3.30
	futures-executor@0.3.30
	futures-io@0.3.30
	futures-macro@0.3.30
	futures-task@0.3.30
	futures-util@0.3.30
	fxhash@0.2.1
	gdk-pixbuf@0.20.0
	gdk-pixbuf-sys@0.20.0
	generic-array@0.14.7
	getrandom@0.2.15
	gif@0.13.1
	gio@0.20.0
	gio-sys@0.20.0
	glib@0.20.0
	glib-macros@0.20.0
	glib-sys@0.20.0
	gobject-sys@0.20.0
	half@2.4.1
	hashbrown@0.14.5
	heck@0.5.0
	hermit-abi@0.3.9
	iana-time-zone@0.1.60
	iana-time-zone-haiku@0.1.2
	idna@0.5.0
	image@0.25.2
	image-webp@0.1.3
	imgref@1.10.1
	indexmap@2.2.6
	interpolate_name@0.2.4
	is-terminal@0.4.12
	is_terminal_polyfill@1.70.0
	itertools@0.10.5
	itertools@0.12.1
	itertools@0.13.0
	itoa@1.0.11
	jobserver@0.1.32
	js-sys@0.3.69
	language-tags@0.3.2
	lazy_static@1.5.0
	libc@0.2.155
	libfuzzer-sys@0.4.7
	libloading@0.8.4
	libm@0.2.8
	linked-hash-map@0.5.6
	linux-raw-sys@0.4.14
	locale_config@0.3.0
	lock_api@0.4.12
	log@0.4.22
	loop9@0.1.5
	lopdf@0.33.0
	mac@0.1.1
	malloc_buf@0.0.6
	markup5ever@0.12.1
	matches@0.1.10
	matrixmultiply@0.3.8
	maybe-rayon@0.1.1
	md-5@0.10.6
	memchr@2.7.4
	minimal-lexical@0.2.1
	miniz_oxide@0.7.4
	nalgebra@0.33.0
	nalgebra-macros@0.2.2
	new_debug_unreachable@1.0.6
	nom@7.1.3
	noop_proc_macro@0.3.0
	normalize-line-endings@0.3.0
	num-bigint@0.4.6
	num-complex@0.4.6
	num-conv@0.1.0
	num-derive@0.4.2
	num-integer@0.1.46
	num-rational@0.4.2
	num-traits@0.2.19
	objc@0.2.7
	objc-foundation@0.1.1
	objc_id@0.1.1
	once_cell@1.19.0
	oorandom@11.1.4
	pango@0.20.0
	pango-sys@0.20.0
	pangocairo@0.20.0
	pangocairo-sys@0.20.0
	parking_lot@0.12.3
	parking_lot_core@0.9.10
	paste@1.0.15
	percent-encoding@2.3.1
	phf@0.10.1
	phf@0.11.2
	phf_codegen@0.10.0
	phf_codegen@0.11.2
	phf_generator@0.10.0
	phf_generator@0.11.2
	phf_macros@0.11.2
	phf_shared@0.10.0
	phf_shared@0.11.2
	pin-project-lite@0.2.14
	pin-utils@0.1.0
	pkg-config@0.3.30
	plotters@0.3.6
	plotters-backend@0.3.6
	plotters-svg@0.3.6
	png@0.17.13
	powerfmt@0.2.0
	ppv-lite86@0.2.17
	precomputed-hash@0.1.1
	predicates@3.1.0
	predicates-core@1.0.6
	predicates-tree@1.0.9
	proc-macro-crate@3.1.0
	proc-macro2@1.0.86
	profiling@1.0.15
	profiling-procmacros@1.0.15
	proptest@1.5.0
	quick-error@1.2.3
	quick-error@2.0.1
	quote@1.0.36
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	rand_xorshift@0.3.0
	rav1e@0.7.1
	ravif@0.11.9
	rawpointer@0.2.1
	rayon@1.10.0
	rayon-core@1.12.1
	rctree@0.6.0
	redox_syscall@0.5.3
	regex@1.10.5
	regex-automata@0.4.7
	regex-syntax@0.8.4
	rgb@0.8.45
	rustix@0.38.34
	rusty-fork@0.3.0
	ryu@1.0.18
	safe_arch@0.7.2
	same-file@1.0.6
	scopeguard@1.2.0
	selectors@0.25.0
	serde@1.0.204
	serde_derive@1.0.204
	serde_json@1.0.120
	serde_spanned@0.6.6
	servo_arc@0.3.0
	shell-words@1.1.0
	simba@0.9.0
	simd-adler32@0.3.7
	simd_helpers@0.1.0
	siphasher@0.3.11
	slab@0.4.9
	smallvec@1.13.2
	stable_deref_trait@1.2.0
	string_cache@0.8.7
	string_cache_codegen@0.5.2
	strsim@0.11.1
	syn@2.0.71
	system-deps@6.2.2
	system-deps@7.0.1
	target-lexicon@0.12.15
	tempfile@3.10.1
	tendril@0.4.3
	termtree@0.4.1
	thiserror@1.0.62
	thiserror-impl@1.0.62
	time@0.3.36
	time-core@0.1.2
	time-macros@0.2.18
	tinytemplate@1.2.1
	tinyvec@1.8.0
	tinyvec_macros@0.1.1
	toml@0.8.14
	toml_datetime@0.6.6
	toml_edit@0.21.1
	toml_edit@0.22.15
	typenum@1.17.0
	unarray@0.1.4
	unicode-bidi@0.3.15
	unicode-ident@1.0.12
	unicode-normalization@0.1.23
	url@2.5.2
	utf-8@0.7.6
	utf8parse@0.2.2
	v_frame@0.3.8
	version-compare@0.2.0
	version_check@0.9.4
	wait-timeout@0.2.0
	walkdir@2.5.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen@0.2.92
	wasm-bindgen-backend@0.2.92
	wasm-bindgen-macro@0.2.92
	wasm-bindgen-macro-support@0.2.92
	wasm-bindgen-shared@0.2.92
	web-sys@0.3.69
	weezl@0.1.8
	wide@0.7.25
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.8
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-core@0.52.0
	windows-sys@0.52.0
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
	winnow@0.5.40
	winnow@0.6.13
	xml5ever@0.18.1
	yeslogic-fontconfig-sys@6.0.0
	zune-core@0.4.12
	zune-jpeg@0.4.13
"

inherit cargo gnome2 meson multilib-minimal python-any-r1 rust-toolchain vala

DESCRIPTION="Scalable Vector Graphics (SVG) rendering library"
HOMEPAGE="https://wiki.gnome.org/Projects/LibRsvg https://gitlab.gnome.org/GNOME/librsvg"
SRC_URI+=" ${CARGO_CRATE_URIS}"

LICENSE="LGPL-2.1+"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD ISC MIT MPL-2.0
	Unicode-DFS-2016
"

SLOT="2"
KEYWORDS="~amd64 ~arm ~arm64 ~loong ~ppc ~ppc64 ~riscv ~sparc ~x86"

IUSE="gtk-doc +introspection +vala"
REQUIRED_USE="
	gtk-doc? ( introspection )
	vala? ( introspection )
"

RDEPEND="
	>=x11-libs/cairo-1.17.0[glib,svg(+),${MULTILIB_USEDEP}]
	>=media-libs/freetype-2.9:2[${MULTILIB_USEDEP}]
	>=x11-libs/gdk-pixbuf-2.20:2[introspection?,${MULTILIB_USEDEP}]
	>=dev-libs/glib-2.50.0:2[${MULTILIB_USEDEP}]
	>=media-libs/harfbuzz-2.0.0:=[${MULTILIB_USEDEP}]
	>=dev-libs/libxml2-2.9.1-r4:2[${MULTILIB_USEDEP}]
	>=x11-libs/pango-1.50.0[${MULTILIB_USEDEP}]

	introspection? ( >=dev-libs/gobject-introspection-0.10.8:= )
"
DEPEND="${RDEPEND}"
BDEPEND="
	>=virtual/rust-1.70.0[${MULTILIB_USEDEP}]
	dev-util/cargo-c
	x11-libs/gdk-pixbuf
	${PYTHON_DEPS}
	$(python_gen_any_dep 'dev-python/docutils[${PYTHON_USEDEP}]')
	gtk-doc? ( dev-util/gi-docgen )
	virtual/pkgconfig
	vala? ( $(vala_depend) )

	dev-libs/gobject-introspection-common
	dev-libs/vala-common
"
# dev-libs/gobject-introspection-common, dev-libs/vala-common needed by eautoreconf

QA_FLAGS_IGNORED="
	usr/bin/rsvg-convert
	usr/lib.*/librsvg.*
"

src_prepare() {
	use vala && vala_setup
	gnome2_src_prepare
}

multilib_src_configure() {
	local myconf=(
		--disable-static
		--disable-debug
		$(multilib_native_use_enable gtk-doc)
		$(multilib_native_use_enable introspection)
		$(multilib_native_use_enable vala)
		--enable-pixbuf-loader
	)

	if ! multilib_is_native_abi; then
		myconf+=(
			# Set the rust target, which can differ from CHOST
			RUST_TARGET="$(rust_abi)"
			# RUST_TARGET is only honored if cross_compiling, but non-native ABIs aren't cross as
			# far as C parts and configure auto-detection are concerned as CHOST equals CBUILD
			cross_compiling=yes
		)
	fi

	# ECONF_SOURCE=${S} \
	# gnome2_src_configure "${myconf[@]}"
	meson_src_configure
	cargo_src_configure
	if multilib_is_native_abi; then
		ln -s "${S}"/doc/html doc/html || die
	fi
}

multilib_src_compile() {
	#gnome2_src_compile
	meson_src_compile
	cargo_src_compile
}

multilib_src_install() {
	#gnome2_src_install
	meson_src_install
	cargo_src_install
}

multilib_src_install_all() {
	find "${ED}" -name '*.la' -delete || die

	if use gtk-doc; then
		mkdir -p "${ED}"/usr/share/gtk-doc/html/ || die
		mv "${ED}"/usr/share/doc/Rsvg-2.0 "${ED}"/usr/share/gtk-doc/html/ || die
	fi
}

pkg_postinst() {
	multilib_foreach_abi gnome2_pkg_postinst
}

pkg_postrm() {
	multilib_foreach_abi gnome2_pkg_postrm
}
