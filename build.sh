#!/bin/sh

# Assuming we are in the WORKDIR as configured in the Dockerfile, or
# overridden on the command line.

# Ensure if any command failes, then the script fails.
set -e

# The clone is _hopefully_ only needed during testing
git clone https://github.com/NOAA-GFDL/FMS.git

# Using an environment variable to get a particular hash/tag/branch (if it
# is set)
if test ! -z $BUILD_VERSION
then
   ( cd FMS && git checkout $BUILD_VERSION )
fi

# Prepare the source directory for building
( cd FMS && autoreconf -if )

# Create the new build directory, and run configure
mkdir build
cd build

# All environment variables (e.g. CC, FC, FCFLAGS, etc) should be set
# via enviornment variables.
../FMS/configure

# Build the library
make -j distcheck

