#!/bin/sh
# Hopefully this is generic enough to work for most builds of libFMS

# Force script to fail on any command failure
set -e

# The following is needed for the Docker CMD.  In the default case, this
# should run the builder script (build.sh).  However, someone can override this
# with a `docker run <image> <command>`.
exec "$@"

