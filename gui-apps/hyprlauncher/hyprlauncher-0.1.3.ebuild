# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A multipurpose and versatile launcher / picker for Hyprland"
HOMEPAGE="https://github.com/hyprwm/hyprlauncher"
SRC_URI="https://github.com/hyprwm/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	gui-libs/hyprtoolkit
	gui-libs/hyprwire
	dev-libs/wayland
	>=gui-libs/hyprutils-0.10.2:=
"
DEPEND="
	${RDEPEND}
	dev-libs/wayland-protocols
"
BDEPEND="
	virtual/pkgconfig
"

DOCS=( README.md )

src_compile() {
	emake protocols
	cmake_src_compile
}
