PRODUCT_BRAND ?= deso

# general properties
PRODUCT_PROPERTIES_OVERRIDE += \
	keyguard.no_require_sim=true \
	ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
	ro.com.google.clientidbase=android-google \
	ro.com.android.wifi-watchlist=GoogleGuest \
	ro.setupwizard.enterprise_mode=1 \
	ro.com.android.dateformat=MM-dd-yyyy \
	ro.com.android.dataroaming=false

PRODUCT_PROPERTY_OVERRIDES += \
	ro.build.selinux=1 \
	persist.sys.root_access=3 \
	dalvik.vm.dex2oat-filter=everything \
    dalvik.vm.image-dex2oat-filter=everything

ADDITIONAL_DEFAULT_PROPERTIES += \
	ro.adb.secure=0 \
	enable_desotweak=true

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/deso/prebuilt/common/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/deso/prebuilt/common/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/deso/prebuilt/common/bin/50-hosts.sh:system/addon.d/50-hosts.sh \
    vendor/deso/prebuilt/common/bin/blacklist:system/addon.d/blacklist

# init.d support
PRODUCT_COPY_FILES += \
	vendor/deso/prebuilt/common/bin/sysinit:system/bin/sysinit

# userinit support
PRODUCT_COPY_FILES += \
    vendor/deso/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit

# Init script file with deso extras
PRODUCT_COPY_FILES += \
    vendor/deso/prebuilt/common/etc/init.local.rc:root/init.deso.rc \
    vendor/deso/prebuilt/common/etc/init.d/91customdensity:system/etc/init.d/91customdensity \
    vendor/deso/prebuilt/common/etc/init.d/01firstbootnotify:system/etc/init.d/01firstbootnotify

#Add System rewriteable/read only scripts
PRODUCT_COPY_FILES += \
    vendor/deso/prebuilt/common/bin/sysrw:system/bin/sysrw  \
    vendor/deso/prebuilt/common/bin/sysrw:system/bin/sysro

# Enable SIP and VoIP on all targets
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Signature compatibility validation from CM
PRODUCT_COPY_FILES += \
    vendor/deso/prebuilt/common/bin/otasigcheck.sh:system/bin/otasigcheck.sh

# Additional packages
-include vendor/deso/config/packages.mk

# Boot animation
-include vendor/deso/config/bootanimation.mk

# Chromium prebuilt
ifeq ($(PRODUCT_PREBUILT_WEBVIEWCHROMIUM),yes)
-include prebuilts/chromium/$(TARGET_DEVICE)/chromium_prebuilt.mk
endif

# SuperSU updater
-include vendor/deso/config/supersu.mk

# ROM Versioning
-include vendor/deso/config/version.mk

-include vendor/deso/sepolicy/sepolicy.mk

# Add our overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/deso/overlay/common
