# Hack for broken FILESEXTRAPATHS_prepend being nuked by Sierra Yocto code - if they fix
# change FILESPATH_prepend to the proper FILESEXTRAPATHS_prepend as required by append scripts.
FILESPATH_prepend := "${LINUX_REPO_DIR}/../meta-mangoh/recipes-kernel/linux/files:"

# Please add all your kernel patches and config fragments below.
# Note that the patches & fragments are not applied to the kernel source
# or defconfig, rather are applied afterwards.
SRC_URI_append = " file://0001-Removed-the-auto-loading-of-cfg80211.patch"
SRC_URI_append = " file://fb.cfg"

# Hack for broken Sierra Yocto builds - if they fix then we can take this out.
do_configure_append() {
    cat ${WORKDIR}/*.cfg >> ${B}/.config
}

