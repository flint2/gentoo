# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=PEVANS
DIST_VERSION=0.821
inherit perl-module

DESCRIPTION="Simple syntax for lexical field-based objects"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="
	dev-perl/File-ShareDir
	>=dev-perl/XS-Parse-Keyword-0.480.0
	>=dev-perl/XS-Parse-Sublike-0.350.0
"
BDEPEND="
	${RDEPEND}
	>=dev-perl/Module-Build-0.400.400
"
