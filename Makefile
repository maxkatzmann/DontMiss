ARCHS = armv7 arm64

THEOS_DEVICE_IP = iDEVICE_IP_GOES_HERE
THEOS_DEVICE_PORT = 22

include theos/makefiles/common.mk

TWEAK_NAME = DontMiss
DontMiss_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 backboardd"
