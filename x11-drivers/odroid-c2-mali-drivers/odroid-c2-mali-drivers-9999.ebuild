EAPI=5

inherit multilib git-r3

EGIT_REPO_URI="https://github.com/mdrjr/c2_mali.git"

DESCRIPTION="Closed source Mali 3d binary blobs for X11"
HOMEPAGE="https://github.com/mdrjr/c2_mali"

SLOT="0"
KEYWORDS="~arm64"
IUSE=""

DEPEND=">=app-eselect/eselect-opengl-1.2.6"
RDEPEND="${DEPEND} media-libs/mesa[-egl,-gles1,-gles2]"

S="${WORKDIR}/${P}/x11"

src_prepare() {
	epatch ${FILESDIR}/installdir.patch
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	# udev rules to get the right ownership/permission for /dev/ump and /dev/mali
	insinto /lib/udev/rules.d
	doins "${FILESDIR}"/99-mali-drivers.rules

	dodir /usr/lib64/pkgconfig
	dodir /usr/include
	emake DESTDIR="${D}" install
}

pkg_postinst() {
	elog "You must be in the video group to use the Mali 3D acceleration."
	elog
	elog "To use the Mali OpenGL ES libraries, run \"eselect opengl set mali\""
}

pkg_prerm() {
	"${ROOT}"/usr/bin/eselect opengl set --use-old --ignore-missing xorg-x11
}

pkg_postrm() {
	"${ROOT}"/usr/bin/eselect opengl set --use-old --ignore-missing xorg-x11
}
