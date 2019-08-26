#!/bin/sh

# Look for ttyUSB devices which match the known location of the USB to UART
# adapter connected to the Cypress Bluetooth on the mangOH Yellow. When such a
# device is identified, either spawn or kill btattach depending on whether the
# UART is being added or removed respectively.
if [ $DEVNAME ] && [ $DEVPATH == "/devices/7c00000.hsic_host/usb1/1-1/1-1.2/1-1.2:1.0/$DEVNAME/tty/$DEVNAME" ]
then
    PIDFILE="/var/run/btattach.$DEVNAME.pid"
    if [ $ACTION == 'add' ]
    then
        echo "Running btattach on /dev/$DEVNAME"
        btattach -P h4 -B /dev/$DEVNAME &
        echo -n $! > $PIDFILE
    elif [ $ACTION == 'remove' ]
    then
        if [ -f $PIDFILE ]
        then
            echo "Killing btattach for /dev/$DEVNAME"
            PID=`cat $PIDFILE`
            kill $PID
            if [ $? -ne 0 ]
            then
                kill -9 $PID
            fi
            rm -f $PIDFILE
        fi
    fi
fi
