set(LIBTIRPC_VERSION_STR "1.2.6")

vcpkg_download_distfile(ARCHIVE
    URLS "https://udomain.dl.sourceforge.net/project/libtirpc/libtirpc/${LIBTIRPC_VERSION_STR}/libtirpc-${LIBTIRPC_VERSION_STR}.tar.bz2"
    FILENAME "libtirpc-${LIBTIRPC_VERSION_STR}.tar.bz2"
    SHA512 bcb6b5c062c1301aa1246ec93ae0a5c1d221b8421126d020863517cb814b43ed038fb6c0c2faf4e68ff133b69abefe4f4d42bfc870671da6c27ca941a30b155a
)

vcpkg_extract_source_archive_ex(
    ARCHIVE ${ARCHIVE}
    OUT_SOURCE_PATH SOURCE_PATH
)

vcpkg_configure_make(
    AUTOCONFIG
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
        --disable-gssapi
        --disable-ipv6
        --disable-debug
)

vcpkg_install_make()

vcpkg_execute_required_process(
    COMMAND make install-pkgconfigDATA
    WORKING_DIRECTORY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel
    LOGNAME ${PORT}-install-pkgconfig-data
)
vcpkg_fixup_pkgconfig()

file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)

