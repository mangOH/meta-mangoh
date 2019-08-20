#!/bin/sh

attach_cypress_bt()
{
    btattach -P h4 -B /dev/ttyUSB0 &
}

# bluetoothSensorTag needs to be able to open a socket to dbus-daemon and vice
# versa. Since dbus-daemon runs under smack label "_" it's necessary to allow
# all processes running with label _ to access the bluetoothSensorTag
# application and necessary for bluetoothSensorTag application to be able to
# access all processes running as label _. It is especially unfortunate that
# this has to be customized for each bluetooth Legato app.
sensortag_smack_workaround()
{
    echo "_ app.bluetoothSensorTag rwx---" > /sys/fs/smackfs/load2
    echo "app.bluetoothSensorTag _ rwx---" > /sys/fs/smackfs/load2
}

do_start()
{
    attach_cypress_bt
    sensortag_smack_workaround
}

case $1 in
    start)
        do_start
    ;;

    *)
        echo "Operation $1 - not supported"
        exit 1
    ;;
esac
