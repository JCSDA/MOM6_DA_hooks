# (C) Copyright 2018 UCAR.
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

cmake_minimum_required( VERSION 3.3.2 FATAL_ERROR )

project( mom6_da_hooks Fortran )

set( CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake;${CMAKE_MODULE_PATH} )

set( ECBUILD_DEFAULT_BUILD_TYPE Release )
set( ENABLE_OS_TESTS           OFF CACHE BOOL "Disable OS tests" FORCE )
set( ENABLE_LARGE_FILE_SUPPORT OFF CACHE BOOL "Disable testing of large file support" FORCE )

include( ecbuild_system NO_POLICY_SCOPE )

ecbuild_requires_macro_version( 2.7 )

################################################################################
# Project
################################################################################

ecbuild_declare_project()

ecbuild_enable_fortran( REQUIRED )

################################################################################
# Dependencies
################################################################################

# fms
ecbuild_use_package( PROJECT fms REQUIRED )
include_directories( ${FMS_INCLUDE_DIRS} )

################################################################################
# Definitions
################################################################################


################################################################################
# Export package info
################################################################################

list( APPEND MOM6_DA_HOOKS_TPLS )

set( MOM6_DA_HOOKS_INCLUDE_DIRS ${CMAKE_Fortran_MODULE_DIRECTORY})
set( MOM6_DA_HOOKS_LIBRARIES mom6_da_hooks)

get_directory_property( MOM6_DA_HOOKS_DEFINITIONS COMPILE_DEFINITIONS )

foreach( _tpl ${MOM6_DA_HOOKS_TPLS} )
  string( TOUPPER ${_tpl} TPL )
  list( APPEND MOM6_DA_HOOKS_EXTRA_DEFINITIONS   ${${TPL}_DEFINITIONS}  ${${TPL}_TPL_DEFINITIONS}  )
  list( APPEND MOM6_DA_HOOKS_EXTRA_INCLUDE_DIRS  ${${TPL}_INCLUDE_DIRS} ${${TPL}_TPL_INCLUDE_DIRS} )
  list( APPEND MOM6_DA_HOOKS_EXTRA_LIBRARIES     ${${TPL}_LIBRARIES}    ${${TPL}_TPL_LIBRARIES}    )
endforeach()

################################################################################
# Sources
################################################################################

set( MOM6_DA_HOOKS_LINKER_LANGUAGE Fortran )

include( mom6_da_hooks_compiler_flags )
include_directories( ${MOM6_DA_HOOKS_INCLUDE_DIRS} )

set ( mom6_da_hooks_files
    src/core/ocean_da_core.F90
    src/core/ocean_da_types.F90
    src/core/write_ocean_obs.F90
)

################################################################################
# Library
################################################################################

ecbuild_add_library( TARGET   mom6_da_hooks
                     SOURCES  ${mom6_da_hooks_files}
                     LIBS     ${FMS_LIBRARIES}
                     INCLUDES ${FMS_INCLUDES}
                     LINKER_LANGUAGE ${MOM6_DA_HOOKS_LINKER_LANGUAGE}
                    )

################################################################################
# Finalise configuration
################################################################################

# prepares a tar.gz of the sources and/or binaries
ecbuild_install_project( NAME mom6_da_hooks )

# print the summary of the configuration
ecbuild_print_summary()
