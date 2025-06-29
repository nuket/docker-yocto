#!/usr/bin/env bash

# Use this script to build the Docker image.

# Users who only want to build the firmware should not run this script.

# Instead, use
#
# `./docker-image-run.sh ./build-all.sh` to build the firmware
#
# using the pre-built Docker image.

docker build -f sources/docker/Dockerfile-22.04 -t yocto-build:scarthgap .

if [[ $? -eq "0" ]]; then
    echo
    echo "Built yocto-build Docker image, here it is:"

    docker image ls
else
    echo
    echo "Could not build yocto-build Docker image! Something went wrong."
fi
