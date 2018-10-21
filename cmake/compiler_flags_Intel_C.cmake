# (C) Copyright 2018 UCAR.
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.

####################################################################
# FLAGS COMMON TO ALL BUILD TYPES
####################################################################

if( HAVE_OMP )
  set( CMAKE_C_FLAGS     "${CMAKE_C_FLAGS} -qopenmp")
else( )
  set( CMAKE_C_FLAGS     "${CMAKE_C_FLAGS} -qopenmp-stubs")
endif( )

####################################################################
# RELEASE FLAGS
####################################################################

set( CMAKE_C_FLAGS_RELEASE     "-O3" )

####################################################################
# DEBUG FLAGS
####################################################################

set( CMAKE_C_FLAGS_DEBUG       "-O0 -g -traceback -fp-trap=common" )

####################################################################
# BIT REPRODUCIBLE FLAGS
####################################################################

set( CMAKE_C_FLAGS_BIT         "-O2" )

####################################################################
# LINK FLAGS
####################################################################

set( CMAKE_C_LINK_FLAGS        "" )

####################################################################

# Meaning of flags
# ----------------
# todo

