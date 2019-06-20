DESCRIPTION = "Startup script to attach Bluetooth adapter on mangOH Yellow"
LICENSE = "MPL-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/MPL-2.0;md5=815ca599c9df247a0c7f619bab123dad"
SRC_URI += "file://cypress_bluetooth.sh"

inherit update-rc.d

INITSCRIPT_NAME = "cypress_bluetooth"
# Run after bluez starts
INITSCRIPT_PARAMS = "start 22 S ."

do_install() {
    install -m 0755 ${WORKDIR}/cypress_bluetooth.sh -D ${D}${sysconfdir}/init.d/cypress_bluetooth
}
