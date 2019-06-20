#!/bin/sh

case $1 in
    start)
        btattach -P h4 -B /dev/ttyUSB0 &
    ;;
    *)
        echo "Operation $1 - not supported"
        exit 1
    ;;
esac
