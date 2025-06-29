#!/bin/bash

#
# Use this script to build the Yocto firmware, by running:
#
# ./docker-image-run.sh ./build-all.sh
#

# By default, this script uses the current folder, but you can also
# set this explicitly to something else.

WORKDIR=$(pwd)

# If you call it without any parameters, it will put you into a bash shell
# running inside the Docker container, where you can then do iterative
# development.

# Notes on docker command-line options used:

# We use bind mounts to only allow the script to access parts of the host system.
#
# You might have to change some of these mounts, if you're using a different
# folder structure.
#
# * If you get an error about a folder not existing on the host, you need to
#   create that folder first.
#
#   See: https://docs.docker.com/storage/bind-mounts/#differences-between--v-and---mount-behavior
#
# * If you get this error:
#
#   Delete the tmp folder and try again.

# .rnd is for openssl
#
# openssl by default will try to write to $HOME/.rnd for some reason
# so this file needs to exist in the host before being mounted read-write into
# the container.

touch $HOME/.rnd

docker run -it --rm \
    --name build-yocto \
    --mount type=bind,source=/etc/passwd,target=/etc/passwd,readonly \
    --mount type=bind,source=/etc/group,target=/etc/group,readonly \
    --mount type=bind,source=$HOME/.rnd,target=$HOME/.rnd \
    --mount type=bind,source=$HOME/.ssh,target=$HOME/.ssh \
    --mount type=bind,source=$WORKDIR,target=$WORKDIR \
    --user $(id -u):$(id -g) \
    --workdir $WORKDIR \
    yocto-build-24.04:scarthgap $*
