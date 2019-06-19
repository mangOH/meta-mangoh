# Start/stop bluez in rcS.d because that's the only runlevel that busybox supports
INITSCRIPT_PARAMS = "start 21 S . stop 79 S ."

