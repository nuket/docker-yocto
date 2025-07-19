#!/usr/bin/env bash

# Use this script to build the Yocto Firmware, it must be run from
# inside the Docker image created by docker-image-build.sh

# Use like this:
# ./docker-image-run.sh ./build-all.sh

# echo
# echo "Building (TI):"
# ./get-revs.sh

if [[ ! $INSIDE_DOCKER ]]; then
    echo "This script must be run from within Docker."
    exit 0
fi

echo "Start running in $(pwd)"

BUILDFOLDER=build-ebp001-ti

set -x
git rev-parse HEAD
git submodule status
set +x

if [[ -d $BUILDFOLDER/conf ]]; then
    echo
    echo "Use existing build folder"

    source sources/poky/oe-init-build-env $BUILDFOLDER

    echo
    echo "Running next commands in folder: $(pwd)"

    echo
    echo "core-image-minimal Build started:  $(date)" | tee -a build-benchmarks.txt

    # Adjust the thread values to make best use of your machine.
    bitbake core-image-minimal

    echo
    echo "core-image-minimal Build finished: $(date)" | tee -a build-benchmarks.txt
fi
