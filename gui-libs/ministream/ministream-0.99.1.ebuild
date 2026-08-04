# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..15} )
inherit gnome.org meson python-any-r1 virtualx xdg

DESCRIPTION="A very small subset of libappstream, intended to be used by libadwaita"
HOMEPAGE="https://gnome.pages.gitlab.gnome.org/libadwaita/ https://gitlab.gnome.org/GNOME/ministream"

LICENSE="LGPL-2.1+"
SLOT="1"
KEYWORDS="~amd64 ~arm ~arm64 ~loong ~ppc ~ppc64 ~riscv ~x86"

IUSE="ascompare +introspection test"

RDEPEND="
	>=dev-libs/glib-2.84.0:2
	>=gui-libs/gtk-4.23.1:4[introspection?]
	introspection? ( >=dev-libs/gobject-introspection-1.83.2:= )
	ascompare? (
		dev-libs/appstream:=
		dev-libs/libxml2
	)
"
DEPEND="${RDEPEND}
"
BDEPEND="
	${PYTHON_DEPS}
	dev-util/glib-utils
	sys-devel/gettext
	virtual/pkgconfig
	dev-lang/sassc
"

src_prepare() {
	default
	xdg_environment_reset
}

src_configure() {
	local emesonargs=(

		$(meson_feature ascompare as-compare)
		$(meson_feature introspection)
		$(meson_use test tests)
	)
	meson_src_configure
}

src_test() {
	addwrite /dev/dri
	virtx meson_src_test --timeout-multiplier 2
}

src_install() {
	meson_src_install
}
