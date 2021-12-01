#!/bin/bash

# check if podman or docker is installed
if [ -x "$(command -v podman)" ]; then
    echo 'Found podman installation' >&2
    CMD=podman
elif [ -x "$(command -v docker)" ]; then
    echo 'Found docker installation' >&2
    CMD=docker
else 
    echo 'Found neither docker nor podman installation' >&2
    exit 1
fi

cnt=$(podman ps -a | grep iot-RTT-container | wc -l)

$CMD run --rm -it --name iot-RTT-container-${cnt} -v /dev/usb:/dev/usb -v /run/udev:/run/udev:ro \
	 --network host --privileged --group-add keep-groups \
	 --ipc host -e DISPLAY=$DISPLAY  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
     docker.io/lehrchristoph/vu_internet_of_things_container:latest bash -lc "/opt/SEGGER/JLink/JLinkRTTViewerExe"