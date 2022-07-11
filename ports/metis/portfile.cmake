vcpkg_check_linkage(ONLY_STATIC_LIBRARY)
set(OPTIONS -DSHARED=OFF)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO KarypisLab/METIS
    REF v5.1.1-DistDGL-v0.5
    SHA512 18b43bdc6239f6b4a60e2d43c3e51ee4c2b829b4ebaa45df3bd9dc5e8d452fe6b1e33151faa566b6481b1ad519fed2fb84fab7962030bc68e3ab5b5767908e22
    HEAD_REF master
    PATCHES
        enable-install.patch
        disable-programs.patch
        fix-runtime-install-destination.patch
        fix-metis-vs14-math.patch
        fix-gklib-vs14-math.patch
        fix-linux-build-error.patch
        install-metisConfig.patch
        fix-INT_MIN_define.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS ${OPTIONS}
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/metis)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

# Handle copyright
file(COPY ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/metis)
file(INSTALL ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
