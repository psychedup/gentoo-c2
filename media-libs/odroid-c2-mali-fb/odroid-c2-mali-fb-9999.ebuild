EAPI=5

inherit git-r3

EGIT_REPO_URI="git://github.com/mdrjr/c2_mali.git"

DESCRIPTION="Closed source framebuffer drivers for Mali-450 Odroid-C2"
HOMEPAGE="https://github.com/mdrjr/c2_mali.git"

SLOT="0"
KEYWORDS="~arm64 ~arm"
IUSE=""

DEPEND="!x11-libs/mesa"

src_compile() {
	touch .gles-only
}

src_install() {
	dodir /usr/include

    if use arm64; then
		dolib.so fbdev/mali_libs/libEGL.so
		dolib.so fbdev/mali_libs/libEGL.so.1
		dolib.so fbdev/mali_libs/libEGL.so.1.4
		dolib.so fbdev/mali_libs/libGLESv1_CM.so
		dolib.so fbdev/mali_libs/libGLESv1_CM.so.1
		dolib.so fbdev/mali_libs/libGLESv1_CM.so.1.1
		dolib.so fbdev/mali_libs/libGLESv2.so
		dolib.so fbdev/mali_libs/libGLESv2.so.2
		dolib.so fbdev/mali_libs/libGLESv2.so.2.0
		dolib.so fbdev/mali_libs/libMali.so
	else
		dolib.so fbdev/32bit_libs/libEGL.so
		dolib.so fbdev/32bit_libs/libEGL.so.1
		dolib.so fbdev/32bit_libs/libEGL.so.1.4
		dolib.so fbdev/32bit_libs/libGLESv1_CM.so
		dolib.so fbdev/32bit_libs/libGLESv1_CM.so.1
		dolib.so fbdev/32bit_libs/libGLESv1_CM.so.1.1
		dolib.so fbdev/32bit_libs/libGLESv2.so
		dolib.so fbdev/32bit_libs/libGLESv2.so.2
		dolib.so fbdev/32bit_libs/libGLESv2.so.2.0
		dolib.so fbdev/32bit_libs/libMali.so
	fi

	insinto /usr/include/EGL
	doins fbdev/mali_headers/EGL/egl.h
	doins fbdev/mali_headers/EGL/eglext.h
	doins fbdev/mali_headers/EGL/eglplatform.h
	doins fbdev/mali_headers/EGL/fbdev_window.h 

	insinto /usr/include/GLES
	doins fbdev/mali_headers/GLES/gl.h
	doins fbdev/mali_headers/GLES/glext.h
	doins fbdev/mali_headers/GLES/glplatform.h

	insinto /usr/include/GLES2
	doins fbdev/mali_headers/GLES2/gl2.h
	doins fbdev/mali_headers/GLES2/gl2ext.h
	doins fbdev/mali_headers/GLES2/gl2platform.h

	insinto /usr/include/KHR
	doins fbdev/mali_headers/KHR/khrplatform.h
}

