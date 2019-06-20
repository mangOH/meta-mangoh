# For some reason (possibly mdev vs udev), the ftdi_sio kernel module is not automatically loaded
# when the onboard FTDI chip is enumerated on a mangOH Yellow. Explicitly load ftdi_sio as a
# workaround. TODO: Is there a better place to add this statement? Perhaps in a mangOH layer?
KERNEL_MODULE_AUTOLOAD += "ftdi_sio"
