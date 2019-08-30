DESCRIPTION = "Startup script to turn off Wifi by default on mangOH Yellow"
LICENSE = "MPL-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/MPL-2.0;md5=815ca599c9df247a0c7f619bab123dad"
SRC_URI += "file://cypress_wifi_off.sh"

inherit update-rc.d

INITSCRIPT_NAME = "cypress_wifi_off"
# Run after BT stuff for now - only dependency is before Legato at S32
INITSCRIPT_PARAMS = "start 23 S ."

do_install() {
    install -m 0755 ${WORKDIR}/cypress_wifi_off.sh -D ${D}${sysconfdir}/init.d/cypress_wifi_off
}
