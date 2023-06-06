export PREFIX = /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/
export SDKVERSION = 14.4
export ARCHS = arm64 arm64e

INSTALL_TARGET_PROCESSES = SharingViewService

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DarkPods

DarkPods_FILES = Tweak.x
DarkPods_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
