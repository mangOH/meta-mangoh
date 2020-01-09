DESCRIPTION = "Linux Backports"
HOMEPAGE = "https://backports.wiki.kernel.org"
SECTION = "kernel/modules"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=d7810fab7487fb0aad327b76f1be7cd7"

PV = "4.14-rc2-1"

#inherit module
inherit module-base

# To generate the backports tree yourself, so you can make modifications:
# Generate the backport tree using:
#    https://github.com/mangOH/linux-backports-generated/blob/master/README.md
# git init, add/commit the generated tree
# Change SRCREV = to point to your generated tree
# Under SRC_URI point this at your generated tree as such:
#    git:///home/user/linux-backports-generated;protocol=file \

SRCREV = "ec72e1b1bb3f096bce9fa6060183db26f8352933"
SRC_URI = " \
    git://github.com/mangOH/linux-backports-generated.git \
    file://backports_config \
"

# Depend on linux-quic to ensure that the kernel is built before we try to build the backports
DEPENDS += "linux-quic"
DEPENDS += "coreutils-native"

S = "${WORKDIR}/git"


# TODO: Is there a better way to set KLIB_BUILD?
EXTRA_OEMAKE = " \
    ARCH=${TARGET_ARCH} \
    CROSS_COMPILE=${TARGET_PREFIX} \
    KLIB_BUILD=${B}/../../../linux-quic/${KERNEL_VERSION}-r1/build \
    KLIB=${B} \
    "

do_configure() {
    make CFLAGS="" CPPFLAGS="" CXXFLAGS="" LDFLAGS="" CC="${BUILD_CC}" LD="${BUILD_LD}" \
        AR="${BUILD_AR}" -C ${S}/kconf O=${S}/kconf conf

    cp ${WORKDIR}/backports_config ${S}/.config
    oe_runmake oldconfig
}

do_compile() {
    oe_runmake
}

do_install() {
    install -d ${D}/lib/modules/${KERNEL_VERSION}/backports
    for ko in $(find ${S} -type f -name '*.ko')
    do
        install -m 0644 $ko ${D}/lib/modules/${KERNEL_VERSION}/backports/
    done
}

FILES_${PN} = " \
    /lib/modules/${KERNEL_VERSION}/backports/ \
    "
