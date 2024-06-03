# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aes@0.8.4
	ahash@0.8.11
	aho-corasick@1.1.3
	allocator-api2@0.2.18
	anstream@0.6.15
	anstyle@1.0.8
	anstyle-parse@0.2.5
	anstyle-query@1.1.1
	anstyle-wincon@3.0.4
	async-broadcast@0.7.1
	async-channel@2.3.1
	async-executor@1.13.0
	async-fs@2.1.2
	async-io@2.3.4
	async-lock@3.4.0
	async-net@2.0.0
	async-process@2.2.4
	async-recursion@1.1.1
	async-signal@0.2.10
	async-task@4.7.1
	async-trait@0.1.82
	atomic-waker@1.1.2
	autocfg@1.3.0
	bitflags@2.6.0
	block@0.1.6
	block-buffer@0.10.4
	block-padding@0.3.3
	blocking@1.6.1
	byteorder@1.5.0
	cairo-rs@0.20.1
	cairo-sys-rs@0.20.0
	cbc@0.1.2
	cc@1.1.15
	cfg-expr@0.16.0
	cfg-if@1.0.0
	cfg_aliases@0.2.1
	cipher@0.4.4
	colorchoice@1.0.2
	concurrent-queue@2.5.0
	cpufeatures@0.2.13
	crossbeam-utils@0.8.20
	crypto-common@0.1.6
	digest@0.10.7
	endi@1.1.0
	enumflags2@0.7.10
	enumflags2_derive@0.7.10
	env_filter@0.1.2
	env_logger@0.11.5
	equivalent@1.0.1
	errno@0.3.9
	event-listener@5.3.1
	event-listener-strategy@0.5.2
	fastrand@2.1.1
	field-offset@0.3.6
	futures@0.3.30
	futures-channel@0.3.30
	futures-core@0.3.30
	futures-executor@0.3.30
	futures-io@0.3.30
	futures-lite@2.3.0
	futures-macro@0.3.30
	futures-sink@0.3.30
	futures-task@0.3.30
	futures-util@0.3.30
	gdk-pixbuf@0.20.1
	gdk-pixbuf-sys@0.20.1
	gdk4@0.9.0
	gdk4-sys@0.9.0
	generic-array@0.14.7
	getrandom@0.2.15
	gettext-rs@0.7.1
	gettext-sys@0.21.4
	gio@0.20.1
	gio-sys@0.20.1
	glib@0.20.2
	glib-macros@0.20.2
	glib-sys@0.20.2
	gobject-sys@0.20.1
	graphene-rs@0.20.1
	graphene-sys@0.20.1
	gsk4@0.9.0
	gsk4-sys@0.9.0
	gtk4@0.9.1
	gtk4-macros@0.9.1
	gtk4-sys@0.9.0
	hashbrown@0.14.5
	heck@0.5.0
	hermit-abi@0.4.0
	hex@0.4.3
	hkdf@0.12.4
	hmac@0.12.1
	humantime@2.1.0
	indexmap@2.5.0
	inout@0.1.3
	is_terminal_polyfill@1.70.1
	lazy_static@1.5.0
	libadwaita@0.7.0
	libadwaita-sys@0.7.0
	libc@0.2.158
	libm@0.2.8
	linux-raw-sys@0.4.14
	locale_config@0.3.0
	log@0.4.22
	lru@0.12.4
	malloc_buf@0.0.6
	md-5@0.10.6
	memchr@2.7.4
	memoffset@0.9.1
	nix@0.29.0
	num@0.4.3
	num-bigint@0.4.6
	num-bigint-dig@0.8.4
	num-complex@0.4.6
	num-integer@0.1.46
	num-iter@0.1.45
	num-rational@0.4.2
	num-traits@0.2.19
	objc@0.2.7
	objc-foundation@0.1.1
	objc_id@0.1.1
	once_cell@1.19.0
	oo7@0.3.3
	ordered-stream@0.2.0
	pango@0.20.1
	pango-sys@0.20.1
	parking@2.2.0
	pbkdf2@0.12.2
	pin-project-lite@0.2.14
	pin-utils@0.1.0
	piper@0.2.4
	pkg-config@0.3.30
	polling@3.7.3
	ppv-lite86@0.2.20
	proc-macro-crate@3.2.0
	proc-macro2@1.0.86
	quote@1.0.37
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	regex@1.10.6
	regex-automata@0.4.7
	regex-syntax@0.8.4
	rustc_version@0.4.1
	rustix@0.38.35
	semver@1.0.23
	serde@1.0.209
	serde_derive@1.0.209
	serde_repr@0.1.19
	serde_spanned@0.6.7
	sha1@0.10.6
	sha2@0.10.8
	shell-words@1.1.0
	shlex@1.3.0
	signal-hook-registry@1.4.2
	slab@0.4.9
	smallvec@1.13.2
	spin@0.9.8
	static_assertions@1.1.0
	subtle@2.6.1
	syn@2.0.77
	system-deps@7.0.2
	target-lexicon@0.12.16
	temp-dir@0.1.13
	tempfile@3.12.0
	toml@0.8.19
	toml_datetime@0.6.8
	toml_edit@0.22.20
	tracing@0.1.40
	tracing-attributes@0.1.27
	tracing-core@0.1.32
	typenum@1.17.0
	uds_windows@1.1.0
	unicode-ident@1.0.12
	utf8parse@0.2.2
	version-compare@0.2.0
	version_check@0.9.5
	wasi@0.11.0+wasi-snapshot-preview1
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
	winnow@0.6.18
	xdg-home@1.3.0
	zbus@4.4.0
	zbus_macros@4.4.0
	zbus_names@3.0.0
	zerocopy@0.7.35
	zerocopy-derive@0.7.35
	zeroize@1.8.1
	zeroize_derive@1.4.2
	zvariant@4.2.0
	zvariant_derive@4.2.0
	zvariant_utils@2.1.0
"

inherit cargo gnome.org gnome2-utils meson xdg

DESCRIPTION="A document viewer for the GNOME desktop"
HOMEPAGE="https://apps.gnome.org/Papers"

SRC_URI+=" ${CARGO_CRATE_URIS}"
LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions CC-BY-SA-3.0 BSD-2 GPL-2+ MIT Unicode-DFS-2016 Unlicense"

SLOT="0"
KEYWORDS="~amd64"
IUSE="cups djvu gstreamer gnome keyring doc +introspection nautilus postscript spell tiff xps"
REQUIRED_USE="doc? ( introspection )"

# atk used in libview
# bundles unarr
DEPEND="
	>=x11-libs/gdk-pixbuf-2.40:2
	>=dev-libs/glib-2.75.0:2
	>=gui-libs/gtk-4.15.2[cups?,introspection?]
	>=gui-libs/libadwaita-1.6_beta
	>=media-libs/exempi-2.0
	>=x11-libs/cairo-1.14
	nautilus? ( gnome-base/nautilus )
	sys-libs/zlib:=
	gnome-base/gsettings-desktop-schemas
	>=app-text/poppler-22.05.0:=[cairo]
	>=app-arch/libarchive-3.6.0:=
	djvu? ( >=app-text/djvu-3.5.22:= )
	gstreamer? (
		media-libs/gstreamer:1.0
		media-libs/gst-plugins-base:1.0
		media-libs/gst-plugins-good:1.0 )
	gnome? ( gnome-base/gnome-desktop:3= )
	keyring? ( >=app-crypt/libsecret-0.5 )
	introspection? ( >=dev-libs/gobject-introspection-1:= )
	postscript? ( >=app-text/libspectre-0.2:= )
	spell? ( >=app-text/gspell-1.6.0:= )
	tiff? ( >=media-libs/tiff-4.0:= )
	xps? ( >=app-text/libgxps-0.2.1:= )
"
RDEPEND="${DEPEND}
	gnome-base/gvfs
	gnome-base/librsvg
"
BDEPEND="
	doc? (
		>=dev-util/gi-docgen-2021.1
		app-text/docbook-xml-dtd:4.3
	)
	dev-libs/appstream-glib
	dev-util/gdbus-codegen
	dev-util/glib-utils
	dev-util/itstool
	>=sys-devel/gettext-0.19.8
	virtual/pkgconfig
	>=virtual/rust-1.53[rustfmt]
"

QA_FLAGS_IGNORED="usr/bin/${PN} usr/bin/${PN}-monitor"

PATCHES=(
	# "${FILESDIR}/meson-fixes.patch"
)

src_prepare() {
	default
	xdg_environment_reset
}

src_configure() {
	local emesonargs=(
		-Dprofile=default

		-Dviewer=true
		-Dpreviewer=true
		-Dthumbnailer=true
		$(meson_use nautilus)

		-Dcomics=enabled
		$(meson_feature djvu)
		-Dpdf=enabled
		$(meson_feature postscript ps)
		$(meson_feature tiff)
		$(meson_feature xps)

		$(meson_use doc documentation)
		-Duser_doc=true
		$(meson_feature introspection)
		-Ddbus=true
		$(meson_feature keyring)
		$(meson_feature cups gtk_unix_print)
	)
	meson_src_configure
}

src_compile() {
	meson_src_compile
}

src_install() {
	meson_src_install
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
