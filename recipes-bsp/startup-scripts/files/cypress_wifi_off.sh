#!/bin/sh
# This script turns off the Cypress chip that started on power up of the board
# Rationale: power saving & DV[34] of mangOH Yellow have a GNSS co-existence
# issue
# Not Supporting WP85 currently
#uname -a | grep mdm9x15
#if [ $? -eq 0 ] ; then
        #CF3="mdm9x15"
#fi

uname -a | grep mdm9x28
if [ $? -eq 0 ] ; then
        CF3="mdm9x28"
        WL_REG_ON_GPIO=33
fi

if [ -z "${CF3}" ] ; then
        logger "Unknown CF3 Module or wp85"
        exit 1
fi

# Let's turn off the Cypress chip and save power by default
# Legato Wifi PA will turn on
if [ "${CF3}" = "mdm9x28" ] ; then
	echo ${WL_REG_ON_GPIO} > /sys/class/gpio/export 2> /dev/null
	echo out  > /sys/class/gpio/gpio${WL_REG_ON_GPIO}/direction 2> /dev/null
	echo 0  > /sys/class/gpio/gpio${WL_REG_ON_GPIO}/value 2> /dev/null
	logger "WIFI IS OFF BY DEFAULT on WP7[67]xx"
fi
