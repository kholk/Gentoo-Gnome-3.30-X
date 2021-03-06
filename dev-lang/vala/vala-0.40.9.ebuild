# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit gnome2

DESCRIPTION="Compiler for the GObject type system"
HOMEPAGE="https://wiki.gnome.org/Projects/Vala"

LICENSE="LGPL-2.1"
SLOT="0.40"
KEYWORDS="~alpha amd64 arm ~arm64 ~hppa ia64 ~mips ~ppc ~ppc64 ~s390 ~sh sparc x86 ~amd64-fbsd ~x86-fbsd ~arm-linux ~x86-linux"
IUSE="test"

RDEPEND="
	>=dev-libs/glib-2.32:2
	>=dev-libs/vala-common-${PV}
	>=media-gfx/graphviz-2.16
"
DEPEND="${RDEPEND}
	!${CATEGORY}/${PN}:0
	dev-libs/libxslt
	sys-devel/flex
	virtual/pkgconfig
	virtual/yacc
	test? (
		dev-libs/dbus-glib
		>=dev-libs/glib-2.26:2
		dev-libs/gobject-introspection )
"

src_configure() {
	# bug 483134
	export GIT_CEILING_DIRECTORIES="${WORKDIR}"

	# weasyprint enables generation of PDF from HTML
	gnome2_src_configure \
		--disable-unversioned \
		VALAC=: \
		WEASYPRINT=:
}
src_install() {
	gnome2_src_install
	rm -r ${D}/usr/share/valadoc
	rm -r ${D}/usr/lib64/valadoc
	rm ${D}/usr/bin/valadoc-0.40
	rm ${D}/usr/lib64/libvaladoc-0.40.so.0.0.0
}
