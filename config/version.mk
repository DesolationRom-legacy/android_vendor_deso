# Versioning of the ROM

TARGET_PRODUCT_SHORT := $(TARGET_PRODUCT)
TARGET_PRODUCT_SHORT := $(subst deso_,,$(TARGET_PRODUCT_SHORT))

ROM_VERSION_MAJOR := 1
ROM_VERSION_MINOR := $(shell date -u +%m.%d)
ROM_VERSION := v$(ROM_VERSION_MAJOR).$(ROM_VERSION_MINOR)

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

ifdef BUILDTYPE_RELEASE
	ROM_BUILDTYPE := Release
	changelog_date := $(shell date -d "1 month ago" '+%m-%d-%Y')
endif

ifndef ROM_BUILDTYPE
	ROM_BUILDTYPE := Unofficial
endif

ifndef changelog_date
	 changelog_date := $(shell date -d "2 weeks ago" '+%m-%d-%Y')
endif

ifdef CHANGELOG_DATE_OVERRIDE
	 changelog_date := $(CHANGELOG_DATE_OVERRIDE)
endif

DESO_VERSION := $(ROM_BUILDTYPE)

# Apply it to build.prop
PRODUCT_PROPERTY_OVERRIDES += \
	ro.modversion=Desolation-$(TARGET_PRODUCT_SHORT) \
	ro.delta.device=$(DESO_PRODUCT) \
	ro.deso.version=$(ROM_VERSION) \
	rom.buildtype=$(ROM_BUILDTYPE)
