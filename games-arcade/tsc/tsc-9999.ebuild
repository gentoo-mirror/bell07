# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=7

DESCRIPTION="The Secret Chronicles of Dr. M."
HOMEPAGE="https://secretchronicles.org/"

EGIT_REPO_URI="https://github.com/Secretchronicles/TSC"
EGIT_BRANCH="devel"
EGIT_SUBMODULES=( '*' '-shared-modules' '-flatpak/shared-modules' )

inherit git-r3


LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+expat"

RDEPEND="media-libs/libsfml
	<dev-games/cegui-0.9[opengl,devil]
	expat? ( dev-games/cegui[expat] )
	!expat? ( dev-games/cegui[xml] )
	media-libs/libpng
	dev-libs/libpcre
	dev-cpp/libxmlpp:2.6"

DEPEND="${RDEPEND}
	dev-libs/boost"

BDEPEND="sys-devel/bison
	dev-lang/ruby"

S="${WORKDIR}/tsc-${PV}/tsc"

inherit cmake

src_configure() {
	local mycmakeargs=(
		-DUSE_LIBXMLPP3=OFF
		-DCEGUI_USE_EXPAT=$(usex expat)
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	rm -r "${D}/usr/share/appdata/"
	rm -r "${D}/usr/share/doc/tsc/"
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
