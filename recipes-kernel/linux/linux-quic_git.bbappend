# Hack for broken FILESEXTRAPATHS_prepend being nuked by Sierra Yocto code - if they fix
# change FILESPATH_append to the proper FILESEXTRAPATHS_prepend/append as required by
# prepend/append scripts.
FILESPATH_append := ":${THISDIR}/files:"

# Please add all your kernel patches and config fragments below.
# Note that the patches & fragments are not applied to the kernel source
# or defconfig, rather are applied afterwards.
SRC_URI_append = " file://0001-Removed-the-auto-loading-of-cfg80211.patch"
SRC_URI_append = " file://0001-wm8944-enable-use-with-digital-mic.patch"
SRC_URI_append = " file://0001-Allowing-sdhci_msm-to-compile-as-a-loadable-module.patch"

# Adding the Framebuffer subsystem and libraries - TODO: delete Frame buffer hardware drivers
SRC_URI_append = " file://fb.cfg"

# Add the Microchip 251x CAN Controller with SPI Interface
SRC_URI_append = " file://can.cfg"

# Make the Qcom MSM-SDHCI module as loadable - TODO: rmmod fails
SRC_URI_append = " file://loadable_sdhci_msm.cfg"

# Hack for broken Sierra Yocto builds - if they fix then we can take this out.
do_configure_append() {
    cat ${WORKDIR}/*.cfg >> ${B}/.config
}

