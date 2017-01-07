$(call inherit-product, vendor/hexa/config/common_mini.mk)

# Required CM packages
PRODUCT_PACKAGES += \
    LatinIME

$(call inherit-product, vendor/hexa/config/telephony.mk)
