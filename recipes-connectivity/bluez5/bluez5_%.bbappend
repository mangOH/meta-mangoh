# This is a workaround for a problem where the files associated with bluez5_5.50.bb are mixed into a
# directory which also contains the files associated with bluez5_%.bbappend in meta-swi. This causes
# the 5.50 files to be picked up by accident when building 5.52. The problem is being fixed upstream
# in meta-swi, but we are still affected until we build against a version of meta-swi that contains
# the fix.
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Start/stop bluez in rcS.d because that's the only runlevel that busybox supports
INITSCRIPT_PARAMS = "start 21 S . stop 79 S ."

# Build without udev support.  udev used to be listed as a dependency in the bluez5 recipe, so
# explicitly remove it from DEPENDS.  It was then managed by PACKAGECONFIG, but the default was to
# enable it, so also remove it from PACKAGECONFIG.
DEPENDS_remove = "udev"
PACKAGECONFIG_remove = "udev"
PACKAGECONFIG[udev] ?= "--enable-udev,--disable-udev,udev"
