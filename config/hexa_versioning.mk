PRODUCT_VERSION_MAJOR = 7
PRODUCT_VERSION_MINOR = 0
PRODUCT_VERSION_MAINTENANCE = 0
PRODUCT_VERSION_MILESTONE = M0

# Set HEXA_BUILDTYPE from the env RELEASE_TYPE, for jenkins compat

ifndef HEXA_BUILDTYPE
    ifdef RELEASE_TYPE
        # Starting with "TO_" is optional
        RELEASE_TYPE := $(shell echo $(RELEASE_TYPE) | sed -e 's|^HEXA_||g')
        HEXA_BUILDTYPE := $(RELEASE_TYPE)
    endif
endif

# Filter out random types, so it'll reset to COMMUNITY
ifeq ($(filter RELEASE NIGHTLY SNAPSHOT EXPERIMENTAL,$(HEXA_BUILDTYPE)),)
    HEXA_BUILDTYPE :=
endif

ifdef HEXA_BUILDTYPE
    ifneq ($(HEXA_BUILDTYPE), SNAPSHOT)
        ifdef HEXA_EXTRAVERSION
            # Force build type to EXPERIMENTAL
            HEXA_BUILDTYPE := EXPERIMENTAL
            # Remove leading dash from HEXA_EXTRAVERSION
            HEXA_EXTRAVERSION := $(shell echo $(HEXA_EXTRAVERSION) | sed 's/-//')
            # Add leading dash to HEXA_EXTRAVERSION
            HEXA_EXTRAVERSION := -$(HEXA_EXTRAVERSION)
        endif
    else
        ifndef HEXA_EXTRAVERSION
            # Force build type to EXPERIMENTAL, SNAPSHOT mandates a tag
            HEXA_BUILDTYPE := EXPERIMENTAL
        else
            # Remove leading dash from HEXA_EXTRAVERSION
            HEXA_EXTRAVERSION := $(shell echo $(HEXA_EXTRAVERSION) | sed 's/-//')
            # Add leading dash to HEXA_EXTRAVERSION
            HEXA_EXTRAVERSION := -$(HEXA_EXTRAVERSION)
        endif
    endif
else
    # If HEXA_BUILDTYPE is not defined, set to COMMUNITY
    HEXA_BUILDTYPE := COMMUNITY
    HEXA_EXTRAVERSION :=
endif

ifeq ($(HEXA_BUILDTYPE), COMMUNITY)
    ifneq ($(TARGET_COMMUNITY_BUILD_ID),)
        HEXA_EXTRAVERSION := -$(TARGET_COMMUNITY_BUILD_ID)
    endif
endif

ifeq ($(HEXA_BUILDTYPE), RELEASE)
    ifndef TARGET_VENDOR_RELEASE_BUILD_ID
        ifeq ($(PRODUCT_VERSION_MAINTENANCE),0)
            HEXA_VERSION := HEXA-$(PRODUCT_VERSION_MILESTONE)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date -u +%Y%m%d)$(PRODUCT_VERSION_DEVICE_SPECIFIC)
        else
            HEXA_VERSION := HEXA-$(PRODUCT_VERSION_MILESTONE)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(shell date -u +%Y%m%d)$(PRODUCT_VERSION_DEVICE_SPECIFIC)
        endif
    else
        ifeq ($(TARGET_BUILD_VARIANT),user)
            HEXA_VERSION := HEXA-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(TARGET_VENDOR_RELEASE_BUILD_ID)
        else
            HEXA_VERSION := HEXA-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)
        endif
    endif
else
    ifeq ($(PRODUCT_VERSION_MINOR),0)
        HEXA_VERSION := HEXA-$(HEXA_BUILDTYPE)$(HEXA_EXTRAVERSION)-$(shell date -u +%Y%m%d-%H%M)
    else
        HEXA_VERSION := HEXA-$(HEXA_BUILDTYPE)$(HEXA_EXTRAVERSION)-$(shell date -u +%Y%m%d-%H%M)
    endif
endif

PRODUCT_PROPERTY_OVERRIDES += \
  ro.hexa.version=$(HEXA_VERSION) \
  ro.hexa.releasetype=$(HEXA_BUILDTYPE) \
  ro.modversion=$(HEXA_VERSION) \
#  ro.cmlegal.url=http://www.cyanogenmod.org/docs/privacy

#-include vendor/cm-priv/keys/keys.mk

HEXA_DISPLAY_VERSION := $(HEXA_VERSION)

ifneq ($(PRODUCT_DEFAULT_DEV_CERTIFICATE),)
ifneq ($(PRODUCT_DEFAULT_DEV_CERTIFICATE),build/target/product/security/testkey)
  ifneq ($(HEXA_BUILDTYPE), COMMUNITY)
    ifndef TARGET_VENDOR_RELEASE_BUILD_ID
      ifneq ($(HEXA_EXTRAVERSION),)
        # Remove leading dash from HEXA_EXTRAVERSION
        HEXA_EXTRAVERSION := $(shell echo $(HEXA_EXTRAVERSION) | sed 's/-//')
        TARGET_VENDOR_RELEASE_BUILD_ID := $(HEXA_EXTRAVERSION)
      else
        TARGET_VENDOR_RELEASE_BUILD_ID := $(shell date -u +%Y%m%d)
      endif
    else
      TARGET_VENDOR_RELEASE_BUILD_ID := $(TARGET_VENDOR_RELEASE_BUILD_ID)
    endif
    HEXA_DISPLAY_VERSION=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(TARGET_VENDOR_RELEASE_BUILD_ID)
  endif
endif
endif
