EAPI=5

inherit git-r3

EGIT_REPO_URI="git://github.com/mdrjr/c2_aml_libs.git"

DESCRIPTION="ODROID-C2 Amlogic Libraries"
HOMEPAGE="https://github.com/mdrjr/c2_aml_libs.git"

SLOT="0"
KEYWORDS="~arm64 ~arm"
IUSE="fbhack"

DEPEND=""
RDEPEND="${DEPEND}
	media-libs/alsa-lib"

src_prepare() {
    if use fbhack; then
    	epatch "${FILESDIR}/silence_fb.patch"
	fi
}

src_compile() {
	emake -C amadec all
	emake -C amavutils all
	emake -C amcodec all
}

src_install() {
	#dodir "/usr/include" "/etc/ld.so.conf.d"

	dodir "/usr/include/amports" "/usr/include/cutils" "/usr/include/ppmgr" "/usr/include/amcodec" "/usr/include/amadec" "/usr/include/amavutils"

	#into /usr/lib/aml_libs
	dolib.so amadec/libamadec.so
	dolib.so amavutils/libamavutils.so
	dolib.so amcodec/libamcodec.so

	insinto /usr/include/amadec
	doins amadec/*.h
	doins amadec/include/*.h

	insinto /usr/include/amavutils
	doins amavutils/include/*.h

	insinto /usr/include/cutils
	doins amavutils/include/cutils/*.h

	insinto /usr/include/amcodec
	doins amcodec/include/*.h

	insinto /usr/include
	doins amcodec/include/*.h

	insinto /usr/include/amports
	doins amcodec/include/amports/*.h

	insinto /usr/include/ppmgr
	doins amcodec/include/ppmgr/*.h
	
	insinto /etc/ld.so.conf.d
	doins aml.conf

	insinto /lib/udev/rules.d
	doins "${FILESDIR}"/99-amlogic.rules
}
