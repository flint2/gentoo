# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
GNOME2_EAUTORECONF="yes"

inherit gnome2 meson

DESCRIPTION="Help browser for GNOME"
HOMEPAGE="https://wiki.gnome.org/Apps/Yelp"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~loong ~ppc ~ppc64 ~riscv ~sparc ~x86 ~amd64-linux ~x86-linux"

RDEPEND="
	app-arch/bzip2:=
	>=app-arch/xz-utils-4.9:=
	dev-db/sqlite:3=
	>=dev-libs/glib-2.67.4:2
	>=dev-libs/libxml2-2.6.5:2=
	>=dev-libs/libxslt-1.1.4
	>=gnome-extra/yelp-xsl-49_beta
	net-libs/webkit-gtk:4.1
	>=x11-libs/gtk+-3.13.3:3
	>=gui-libs/libhandy-1.5.0:1
	x11-themes/adwaita-icon-theme
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-libs/appstream-glib
	>=dev-build/gtk-doc-am-1.13
	dev-util/glib-utils
	dev-util/itstool
	>=sys-devel/gettext-0.19.8
	virtual/pkgconfig
"

src_prepare() {
	default
	meson_src_prepare
}

src_configure() {
	default
	meson_src_configure
}

src_install() {
	default
	meson_src_install
}
