set(LIBEV_VERSION_STR "4.33")

vcpkg_download_distfile(ARCHIVE
    URLS "http://dist.schmorp.de/libev/libev-${LIBEV_VERSION_STR}.tar.gz"
    FILENAME "libev-${LIBEV_VERSION_STR}.tar.gz"
	SHA512 c662a65360115e0b2598e3e8824cf7b33360c43a96ac9233f6b6ea2873a10102551773cad0e89e738541e75af9fd4f3e3c11cd2f251c5703aa24f193128b896b
)

vcpkg_extract_source_archive_ex(
    ARCHIVE ${ARCHIVE}
    OUT_SOURCE_PATH SOURCE_PATH
)

vcpkg_configure_make(
    AUTOCONFIG
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
        --disable-debug
)

vcpkg_install_make()
vcpkg_fixup_pkgconfig()

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)

#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
