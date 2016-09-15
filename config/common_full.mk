# Inherit additional stuff
$(call inherit-product, vendor/hexa/config/common.mk)

# Main Required Packages
PRODUCT_PACKAGES += \
    Camera2 \
    DeskClock \
    Gallery2 \
    Launcher3 \
    LiveWallpapersPicker

# Busybox
PRODUCT_PACKAGES += \
    Busybox
