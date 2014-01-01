ARCHS = armv7 arm64

include theos/makefiles/common.mk

TWEAK_NAME = DontMiss
DontMiss_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk
