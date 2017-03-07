include(ExternalProject)

ExternalProject_Add(snark
    PREFIX deps
    # This points to a February 2017 version.
    DOWNLOAD_NAME snark-6b7e494c.tar.gz
    URL https://github.com/scipr-lab/libsnark/archive/6b7e494c2407eb8e91ad78635788decb2d736596.tar.gz
    URL_HASH SHA256=c40ee69a15c8a5baf3980d3686112ccbe8511071faa1cda3875d43e693fc90e4
    DOWNLOAD_NO_PROGRESS TRUE
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND ""
    BUILD_COMMAND CXX=${CMAKE_CXX_COMPILER} CC=${CMAKE_C_COMPILER} make
        NO_PROCPS=1 STATIC=1 NO_SUPERCOP=1 NO_GTEST=1 NO_DOCS=1 CURVE=ALT_BN128
        FEATUREFLAGS="-DBINARY_OUTPUT=1 -DMONTGOMERY_OUTPUT=1 -DNO_PT_COMPRESSION=1"
        lib PREFIX=<INSTALL_DIR> install
    INSTALL_COMMAND ""
)

# Create snark imported library
ExternalProject_Get_Property(snark INSTALL_DIR)
add_library(Snark STATIC IMPORTED)
set(SNARK_LIBRARY ${INSTALL_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}snark${CMAKE_STATIC_LIBRARY_SUFFIX})
file(MAKE_DIRECTORY ${INSTALL_DIR}/include/libsnark)  # Must exist.
set(SNARK_INCLUDE_DIRS ${INSTALL_DIR}/include ${INSTALL_DIR}/include/libsnark)
set_property(TARGET Snark PROPERTY IMPORTED_LOCATION ${SNARK_LIBRARY})
set_property(TARGET Snark PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${SNARK_INCLUDE_DIRS})
add_dependencies(Snark snark)
unset(INSTALL_DIR)
