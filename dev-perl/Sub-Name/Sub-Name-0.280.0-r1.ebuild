# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=ETHER
DIST_VERSION=0.28
inherit perl-module

DESCRIPTION="(Re)name a sub"

SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x64-solaris"
IUSE="suggested"

RDEPEND="
	>=virtual/perl-Exporter-5.570.0
"
BDEPEND="
	${RDEPEND}
	test? (
		suggested? (
			dev-perl/Devel-CheckBin
		)
		>=virtual/perl-Test-Simple-0.880.0
	)
"
