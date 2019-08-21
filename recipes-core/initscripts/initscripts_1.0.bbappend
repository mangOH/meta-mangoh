FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI += "file://mdev/ttyUSB.sh"

do_install_append() {
    # Install an mdev rule for running btattach on the UART connected to the
    # Cypress Bluetooth adapter on mangOH Yellow
    install -m 0755 ${WORKDIR}/mdev/ttyUSB.sh -D ${D}${sysconfdir}/mdev/ttyUSB.sh
}