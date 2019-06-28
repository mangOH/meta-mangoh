# Start/stop bluez in rcS.d because that's the only runlevel that busybox supports
INITSCRIPT_PARAMS = "start 21 S . stop 79 S ."

# Build without udev support.  udev used to be listed as a dependency in the bluez5 recipe, so
# explicitly remove it from DEPENDS.  It was then managed by PACKAGECONFIG, but the default was to
# enable it, so also remove it from PACKAGECONFIG.
DEPENDS_remove = "udev"
PACKAGECONFIG_remove = "udev"
PACKAGECONFIG[udev] ?= "--enable-udev,--disable-udev,udev"
