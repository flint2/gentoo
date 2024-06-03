# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo gnome2 meson xdg

DESCRIPTION="A document viewer for the GNOME desktop"
HOMEPAGE="https://apps.gnome.org/Papers"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions CC-BY-SA-3.0 BSD-2 GPL-2+ MIT Unicode-DFS-2016 Unlicense"

SLOT="0"
KEYWORDS="~amd64"
IUSE="cups djvu gstreamer gnome keyring doc +introspection nautilus spell tiff"
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
	spell? ( >=app-text/gspell-1.6.0:= )
	tiff? ( >=media-libs/tiff-4.0:= )
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
		$(meson_feature tiff)

		$(meson_use doc documentation)
		-Duser_doc=true
		$(meson_feature introspection)
		$(meson_feature keyring)
		$(meson_feature cups gtk_unix_print)
	)
	meson_src_configure
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
