#!/bin/sh

# Assuming we are in the WORKDIR as configured in the Dockerfile, or
# overridden on the command line.

# Ensure if any command failes, then the script fails.
set -e

# Prepare for the build
autoreconf -if

# All environment variables (e.g. CC, FC, FCFLAGS, etc) should be set
# via enviornment variables.
./configure

# Build the library
make -j distcheck

