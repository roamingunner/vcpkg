set(LIBSECCOMP_VERSION_STR "2.4.4")

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/seccomp/libseccomp/releases/download/v${LIBSECCOMP_VERSION_STR}/libseccomp-${LIBSECCOMP_VERSION_STR}.tar.gz"
    FILENAME "libseccomp-${LIBSECCOMP_VERSION_STR}.tar.gz"
	SHA512 53e5aa338a1c30ce826551e33be6ef877af43b1d8cfd2e1b6ffb70789eb2070d2610fb7cb5cec4a3a4c4a1221767f867f3d2bc07b6b1d9742719b1e053630b24
)

vcpkg_extract_source_archive_ex(
    ARCHIVE ${ARCHIVE}
    OUT_SOURCE_PATH SOURCE_PATH
)

vcpkg_configure_make(
    AUTOCONFIG
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
        --enable-shared
        --disable-static
        --disable-debug
)

vcpkg_install_make()
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)

