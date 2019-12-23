DESCRIPTION = "Support files for the Cypress WiFi on mangOH Yellow"
HOMEPAGE = "https://mangoh.io"
LICENSE = "MPL-2.0"
LIC_FILES_CHKSUM = "file://../cywifi.sh;startline=2;endline=2;md5=4ab7b147102bbb17e696589e8e19383e"

FILES_${PN} = " \
    ${base_libdir}/firmware/brcm/brcmfmac43430-sdio.bin \
    ${base_libdir}/firmware/brcm/brcmfmac43430-sdio.clm_blob \
    ${base_libdir}/firmware/brcm/brcmfmac43430-sdio.txt \
    ${sysconfdir}/init.d/cywifi \
    "

SRC_URI = " \
    file://brcmfmac43430-sdio.bin \
    file://brcmfmac43430-sdio.clm_blob \
    file://brcmfmac43430-sdio.txt \
    file://cywifi.sh \
    "

do_install() {
    install -D -m 0644 ${WORKDIR}/brcmfmac43430-sdio.bin \
        ${D}${base_libdir}/firmware/brcm/brcmfmac43430-sdio.bin
    install -D -m 0644 ${WORKDIR}/brcmfmac43430-sdio.clm_blob \
        ${D}${base_libdir}/firmware/brcm/brcmfmac43430-sdio.clm_blob
    install -D -m 0644 ${WORKDIR}/brcmfmac43430-sdio.txt \
        ${D}${base_libdir}/firmware/brcm/brcmfmac43430-sdio.txt
    install -D -m 0755 ${WORKDIR}/cywifi.sh ${D}${sysconfdir}/init.d/cywifi
}
