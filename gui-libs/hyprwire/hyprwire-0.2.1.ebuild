# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A fast and consistent wire protocol for IPC"
HOMEPAGE="https://github.com/hyprwm/hyprwire"
SRC_URI="https://github.com/hyprwm/${PN}/archive/refs/tags/v${PV}/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"

SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	>=gui-libs/hyprutils-0.9.0:=
"

DEPEND="${RDEPEND}"
