# Versioning of the ROM

TARGET_PRODUCT_SHORT := $(TARGET_PRODUCT)
TARGET_PRODUCT_SHORT := $(subst deso_,,$(TARGET_PRODUCT_SHORT))

ROM_VERSION_MAJOR := 2015
ROM_VERSION_MINOR := RC0

ifdef BUILDTYPE_NIGHTLY
	ROM_BUILDTYPE := Nightly
	changelog_date := $(shell date -d "1 day ago" '+%m-%d-%Y')
endif
ifdef BUILDTYPE_WEEKLY
	ROM_BUILDTYPE := Weekly
	changelog_date := $(shell date -d "1 week ago" '+%m-%d-%Y')
endif
ifdef BUILDTYPE_EXPERIMENTAL
	ROM_BUILDTYPE := Experimental
	changelog_date := $(shell date -d "2 weeks ago" '+%m-%d-%Y')
endif

ROM_VERSION := $(shell date -u +%m.%d).$(BUILD_ID)

ifdef BUILDTYPE_RELEASE
	ROM_BUILDTYPE := Release
	ROM_VERSION := $(BUILD_ID)-v$(ROM_VERSION_MAJOR).$(ROM_VERSION_MINOR)-$(TARGET_PRODUCT_SHORT)
	changelog_date := $(shell date -d "1 month ago" '+%m-%d-%Y')
endif

ifndef ROM_BUILDTYPE
	ROM_BUILDTYPE := Unofficial
endif
ifndef changelog_date
	 changelog_date := $(shell date -d "2 weeks ago" '+%m-%d-%Y')
endif

DESO_VERSION := $(ROM_BUILDTYPE)

# Apply it to build.prop
PRODUCT_PROPERTY_OVERRIDES += \
	ro.modversion=Desolation-$(TARGET_PRODUCT_SHORT) \
	ro.deso.version=$(ROM_VERSION) \
	rom.buildtype=$(ROM_BUILDTYPE)
