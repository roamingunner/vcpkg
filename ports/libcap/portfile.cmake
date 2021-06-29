set(LIBCAP_VERSION_STR "2.45")
vcpkg_download_distfile(ARCHIVE
    URLS "https://mirrors.edge.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-${LIBCAP_VERSION_STR}.tar.xz"
    FILENAME "libcap-${LIBCAP_VERSION_STR}.tar.gz"
	SHA512 32ddc303eeb1bf6a4b6cc81b0cb0c49544c58697735925b661a0cdfa18e4096fdbaed1a340c09b8060b09302dea332b216e9bdaf246e4c45f91211afc4752138
)

vcpkg_extract_source_archive_ex(
    ARCHIVE ${ARCHIVE}
    OUT_SOURCE_PATH SOURCE_PATH
)

string(REPLACE "gcc" "" CMAKE_COMPILER_PREFIX "${CMAKE_C_COMPILER}")

vcpkg_execute_build_process(
    COMMAND make RAISE_SETFCAP=no LIBATTR=no PAM_CAP=no DESTDIR=${CURRENT_PACKAGES_DIR}   -C libcap cap_names.h
    WORKING_DIRECTORY ${SOURCE_PATH}
    LOGNAME ${PORT}-build
)

vcpkg_execute_build_process(
    COMMAND make RAISE_SETFCAP=no LIBATTR=no PAM_CAP=no CROSS_COMPILE=${VCPKG_PLATFORM_TOOLSET}-  -C libcap/ libcap.so
    WORKING_DIRECTORY ${SOURCE_PATH}
    LOGNAME ${PORT}-build
)

vcpkg_execute_build_process(
    COMMAND make RAISE_SETFCAP=no LIBATTR=no PAM_CAP=no CROSS_COMPILE=${VCPKG_PLATFORM_TOOLSET}- DESTDIR=${CURRENT_PACKAGES_DIR} lib=lib prefix=/  -C libcap/ install-shared-cap
    WORKING_DIRECTORY ${SOURCE_PATH}
    LOGNAME ${PORT}-build
)

# vcpkg_install_make()
vcpkg_fixup_pkgconfig()
# make RAISE_SETFCAP=no LIBATTR=no PAM_CAP=no DESTDIR=`pwd`/install   -C libcap cap_names.h
# make RAISE_SETFCAP=no LIBATTR=no PAM_CAP=no CROSS_COMPILE=${CMAKE_COMPILER_PREFIX}-  -C libcap/ libcap.so
# make RAISE_SETFCAP=no LIBATTR=no PAM_CAP=no CROSS_COMPILE=${CMAKE_COMPILER_PREFIX}- DESTDIR=`pwd`/install  lib=lib prefix=/  -C libcap/ install-shared-cap
file(INSTALL ${SOURCE_PATH}/License DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)

