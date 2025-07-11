# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_OPTIONAL=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..12} )
GENTOO_DEPEND_ON_PERL="no"

inherit autotools distutils-r1 perl-functions

MY_PV="$(ver_cut 1-2)"

DESCRIPTION="Library to support AppArmor userspace utilities"
HOMEPAGE="https://gitlab.com/apparmor/apparmor/wikis/home"
SRC_URI="https://launchpad.net/apparmor/${MY_PV}/${PV}/+download/apparmor-${PV}.tar.gz"
S=${WORKDIR}/apparmor-${PV}/libraries/${PN}

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~arm arm64 ~ppc64 ~riscv ~x86"
IUSE="doc +perl +python static-libs"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"
# depends on the package already being installed
RESTRICT="test"

RDEPEND="
	perl? ( dev-lang/perl:= )
	python? (
		${PYTHON_DEPS}
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-build/autoconf-archive
	sys-devel/bison
	sys-devel/flex
	doc? ( dev-lang/perl )
	perl? ( dev-lang/swig )
	python? (
		${PYTHON_DEPS}
		${DISTUTILS_DEPS}
		dev-lang/swig
	)
"

PATCHES=(
	"${FILESDIR}"/${PN}-3.1.4-clang-flto-partition.patch
)

src_prepare() {
	default

	use python && distutils-r1_src_prepare

	# We used to rm m4/ but led to this after eautoreconf:
	# checking whether the libapparmor man pages should be generated... yes
	# ./configure: 5065: PROG_PODCHECKER: not found
	# ./configure: 5068: PROG_POD2MAN: not found
	# checking whether python bindings are enabled... yes
	eautoreconf
}

src_configure() {
	# Run configure through distutils-r1.eclass. Bug 764779
	if use python; then
		distutils-r1_src_configure
	else
		python_configure_all
	fi
}

python_configure_all() {
	# Fails with reflex/byacc, heavily relies on bisonisms
	export LEX=flex
	export YACC=yacc.bison

	local myeconfargs=(
		$(use_enable static-libs static)
		$(use_with perl)
		$(use_with python)
	)

	econf "${myeconfargs[@]}"
}

src_compile() {
	emake -C src
	emake -C include
	use doc && emake -C doc
	use perl && emake -C swig/perl

	if use python ; then
		pushd swig/python > /dev/null
		emake libapparmor_wrap.c
		distutils-r1_src_compile
		popd > /dev/null
	fi
}

src_install() {
	emake DESTDIR="${D}" -C src install
	emake DESTDIR="${D}" -C include install
	use doc && emake DESTDIR="${D}" -C doc install

	if use perl ; then
		emake DESTDIR="${D}" -C swig/perl install
		perl_set_version
		insinto "${VENDOR_ARCH}"
		doins swig/perl/LibAppArmor.pm

		# bug 620886
		perl_delete_localpod
		perl_fix_packlist
	fi

	if use python ; then
		pushd swig/python > /dev/null || die
		distutils-r1_src_install
		popd > /dev/null || die
	fi

	dodoc AUTHORS ChangeLog NEWS README

	find "${D}" -name '*.la' -delete || die
}

python_install() {
	distutils-r1_python_install

	python_moduleinto LibAppArmor
	python_domodule LibAppArmor.py
}
