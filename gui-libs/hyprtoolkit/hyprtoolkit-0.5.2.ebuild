# Copyright 2023-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A modern C++ Wayland-native GUI toolkit"
HOMEPAGE="https://github.com/hyprwm/hyprtoolkit"
SRC_URI="https://github.com/hyprwm/${PN}/archive/refs/tags/v${PV}/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/iniparser
	>=gui-libs/aquamarine-0.10.0
	>=gui-libs/hyprutils-0.11.0:=
"

DEPEND="${RDEPEND}"
