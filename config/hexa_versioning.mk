PRODUCT_VERSION_MAJOR = 7
PRODUCT_VERSION_MINOR = 0
PRODUCT_VERSION_MAINTENANCE = 0
PRODUCT_VERSION_MILESTONE = M0

# Just define what WE NEED. DO NOT MESS UP

HEXA_BUILDTYPE := UNNOFICIAL
HEXA_EXTRAVERSION :=
HEXA_VERSION := HEXA-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date -u +%Y%m%d)-$(HEXA_BUILD)


PRODUCT_PROPERTY_OVERRIDES += \
  ro.hexa.version=$(HEXA_VERSION) \
  ro.hexa.releasetype=$(HEXA_BUILDTYPE) \
  ro.modversion=$(HEXA_VERSION) \
#  ro.cmlegal.url=http://www.cyanogenmod.org/docs/privacy

#-include vendor/cm-priv/keys/keys.mk

HEXA_DISPLAY_VERSION := $(HEXA_VERSION)