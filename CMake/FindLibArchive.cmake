#  LIBARCHIVE_FOUND - system has Libarchive
#  LIBARCHIVE_INCLUDE_DIR - the Libarchive include directory
#  LIBARCHIVE_LIBRARY - Link these to use Libarchive
#  LIBARCHIVE_LIBRARIES

SET(LIBARCHIVE_SEARCH_PATHS
	${POLYCODE_RELEASE_DIR}/Framework/Tools/Dependencies/lib
	${POLYCODE_RELEASE_DIR}/Framework/Tools/Dependencies/include/
)

SET(CMAKE_FIND_LIBRARY_SUFFIXES
	.a
	.lib
)


find_path (LIBARCHIVE_INCLUDE_DIR NAMES archive.h
	HINTS
	NO_DEFAULT_PATH
	NO_CMAKE_ENVIRONMENT_PATH
	NO_CMAKE_SYSTEM_PATH
	NO_SYSTEM_ENVIRONMENT_PATH
	NO_CMAKE_PATH
	CMAKE_FIND_FRAMEWORK NEVER
	PATH_SUFFIXES lib lib64 win32/Dynamic_Release "Win32/${MSVC_YEAR_NAME}/x64/Release" "Win32/${MSVC_YEAR_NAME}/Win32/Release"
	PATHS ${LIBARCHIVE_SEARCH_PATHS}
)
 
find_library (LIBARCHIVE_LIBRARY_DEBUG NAMES archived libarchived libarchive_d PATHS ${LIBARCHIVE_SEARCH_PATHS})
find_library (LIBARCHIVE_LIBRARY_RELEASE NAMES archive libarchive PATHS ${LIBARCHIVE_SEARCH_PATHS})

if (LIBARCHIVE_INCLUDE_DIR AND LIBARCHIVE_LIBRARY_RELEASE)
  set(LIBARCHIVE_FOUND TRUE)
endif()

if (LIBARCHIVE_LIBRARY_RELEASE)
    set (LIBARCHIVE_LIBRARY ${LIBARCHIVE_LIBRARY_RELEASE})
endif()

if (LIBARCHIVE_LIBRARY_DEBUG AND LIBARCHIVE_LIBRARY_RELEASE)
    set (LIBARCHIVE_LIBRARY debug ${LIBARCHIVE_LIBRARY_DEBUG} optimized ${LIBARCHIVE_LIBRARY_RELEASE} )
endif()


if (LIBARCHIVE_FOUND)
  MESSAGE("-- Found Libarchive: ${LIBARCHIVE_LIBRARY}")
  mark_as_advanced (LIBARCHIVE_INCLUDE_DIR LIBARCHIVE_LIBRARY LIBARCHIVE_LIBRARIES)
else()
  MESSAGE("-- Could not find LibArchive!")
endif()

