#!/bin/sh
# Copyright (C) Sierra Wireless Inc. Use of this work is subject to license.
#
# Broadcom/Cypress chip startup for mangOH Yellow

export PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin

# mangOH Yellow DV3 uses GPIO33 and DV4 uses wl_reg_on on the expander
# It seems different DV3 boards were sent in the Yellow giveaway with different formats
# So relax the search for the DV3 string
head -n 2 /sys/bus/i2c/devices/4-0050/eeprom | grep -q DV3
if [ $? -eq 0 ] ; then
    BOARD_REV="DV3"
    WL_REG_ON_GPIO=33
fi

cy_wifi_start() {
    # Let's bring the Cypress chip out of reset
    if [ -n "$BOARD_REV" ] && [ ${BOARD_REV} == "DV3" ] ; then
        # DV3
        if [ ! -d "/sys/class/gpio/gpio${WL_REG_ON_GPIO}" ] ; then
            echo ${WL_REG_ON_GPIO} > /sys/class/gpio/export
            echo out > /sys/class/gpio/gpio${WL_REG_ON_GPIO}/direction
        fi
        WL_REG_ON_VALUE=`cat /sys/class/gpio/gpio${WL_REG_ON_GPIO}/value`
        if [ $WL_REG_ON_VALUE -eq 0 ] ; then
            echo 1  > /sys/class/gpio/gpio${WL_REG_ON_GPIO}/value
        fi
    else
        # Otherwise let's assume Rev 1.0 or greater
        echo 1  > /sys/devices/platform/expander.0/wl_reg_on
    fi

    # TODO: fix. WL_HOST_WAKE (GPIO42) should tell us that the
    # the Cypress chip is powered on. On DV[34], may not be
    # connected. If it works the sleep below can be removed.
    sleep 2
    modprobe sdhci-msm
    # TODO: fix. Remove sleep below after more testing.
    # Thought I saw issues in the BRCM FMAC coming up to soon.
    # Btw, brcmfmac does have reconnect to sdio code.
    sleep 2

    # Let's make sure the Cypress chip got attached by the Kernel's MMC framework
    # Bug here if dmesg has overflowed - for now we are removing the code below
    # as we will assume MMC enumeration happened. Need a better way to error check
    # as the driver on the WP76 continuously polls CIS tuples ad-infinitum and messes up the log
    #sleep 3
    # TODO: Return exit code 50 here as the Chip was not scanned across SDIO
    dmesg | grep "new high speed SDIO card" > /dev/null 2>&1
    if [ $? -ne 0 ] ; then
        echo "Cypress chip MMC recognition may have been overwritten"
        #exit 2
    fi

    # load the drivers
    modprobe brcmfmac

    # firmware loads and reboots the Cypress device
    sleep 5

    ifconfig -a | grep wlan0 >/dev/null
    if [ $? -ne 0 ] ; then
        echo "wlan0 interface was not created by Cypress drivers"; exit 100
    fi
    ifconfig wlan0 up >/dev/null
    if [ $? -ne 0 ] ; then
        echo "wlan0 interface UP not working; exit 127"
    fi
}

cy_wifi_stop() {
    ifconfig | grep wlan0 >/dev/null
    # TODO FIX:  For now we have commented rmmod's and kicking the Cypress chip
    # The sdhci-msm crashes on modprobe -r
    #if [ $? -eq 0 ]; then
    #ifconfig wlan0 down
    #fi
    #modprobe -r brcmfmac || exit 127
    #modprobe -r sdhci-msm

    # Turn off the Cypress chip
    #echo 0  > /sys/class/gpio/gpio${WL_REG_ON_GPIO}/value
}

case "$1" in
    start)
	cy_wifi_start
	;;
    stop)
	cy_wifi_stop
	;;
    restart)
	cy_wifi_stop
	cy_wifi_start
	;;
    *)
	exit 99
	;;
esac

exit 0
