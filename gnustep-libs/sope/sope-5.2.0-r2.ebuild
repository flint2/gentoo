# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnustep-2 vcs-snapshot

DESCRIPTION="A set of frameworks forming a complete Web application server environment"
HOMEPAGE="https://www.sogo.nu/"
SRC_URI="https://github.com/inverse-inc/sope/archive/SOPE-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnutls ldap mysql postgres +ssl +xml"

RDEPEND="
	sys-libs/zlib
	ldap? ( net-nds/openldap:= )
	gnutls? ( net-libs/gnutls:= )
	!gnutls? (
		dev-libs/openssl:0=
	)
	mysql? ( dev-db/mysql-connector-c:= )
	postgres? ( dev-db/postgresql:= )
	xml? ( dev-libs/libxml2:2= )
"
DEPEND="${RDEPEND}"

src_configure() {
	local ssl_provider
	if use ssl ; then
		if use gnutls ; then
			ssl_provider=gnutls
		else
			ssl_provider=ssl
		fi
	else
		ssl_provider=none
	fi

	egnustep_env

	# Non-standard configure script
	./configure \
		--disable-strip \
		$(use_enable debug) \
		$(use_enable ldap openldap) \
		$(use_enable mysql) \
		$(use_enable postgres postgresql) \
		$(use_enable xml) \
		--with-ssl="${ssl_provider}" \
		--with-gnustep || die "configure failed"
}
