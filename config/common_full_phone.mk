# Inherit common CM stuff
$(call inherit-product, vendor/hexa/config/common_full.mk)

# Required CM packages
PRODUCT_PACKAGES += \
    LatinIME

# Include CM LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/hexa/overlay/dictionaries


$(call inherit-product, vendor/hexa/config/telephony.mk)
