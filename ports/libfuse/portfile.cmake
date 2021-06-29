set(LIBFUSE_VERSION_STR "3.9.3")

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/libfuse/libfuse/archive/refs/tags/fuse-${LIBFUSE_VERSION_STR}.tar.gz"
    FILENAME "fuse-${LIBFUSE_VERSION_STR}.tar.gz"
	SHA512 d475b465af08035e7464e4ab70ef1d24df30d9ce224fdd95ef8334041672bfef2804ab8ac20987c39a8d30359c595a9e4572a6b70a493b5e2d6406e008023792
)

vcpkg_extract_source_archive_ex(
    ARCHIVE ${ARCHIVE}
    OUT_SOURCE_PATH SOURCE_PATH
)

vcpkg_configure_meson(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
        -Ddocs=false
        -Dbin=false
        -Dtests=false
)

vcpkg_install_meson()

vcpkg_fixup_pkgconfig()

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)

#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
