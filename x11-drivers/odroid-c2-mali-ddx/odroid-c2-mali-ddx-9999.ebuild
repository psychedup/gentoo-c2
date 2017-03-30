EAPI=5

inherit git-r3 linux-info flag-o-matic eutils

EGIT_REPO_URI="git://github.com/mdrjr/c2_mali_ddx.git"

DESCRIPTION="Closed-source Mali X11 graphics drivers for Odroid C2 SBC"
HOMEPAGE="https://github.com/mdrjr/c2_mali_ddx"

SLOT="0"
KEYWORDS="~arm64"
IUSE=""

DEPEND="
	x11-drivers/odroid-c2-mali-drivers
"

src_configure() {
	econf
	epatch ${FILESDIR}/installdir.patch
}

src_install() {
	dodir /etc/X11
	emake DESTDIR="${D}" install
}
