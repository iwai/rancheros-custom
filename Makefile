MAKEFLAGS    += --warn-undefined-variables
SHELL        := /bin/bash
.SHELLFLAGS  := -eu -o pipefail -c

OS_VERSION      ?= 1.5.2
OS_BASE_VERSION ?= v2018.02.11-1

ARTIFACTS = os-base/dist/artifacts
TARGET    = os-base_amd64.tar.xz


$(ARTIFACTS)/$(TARGET) $(ARTIFACTS)/$(TARGET).busybox-dynamic.config $(ARTIFACTS)/$(TARGET).config:
	cp config/os-base/$(OS_BASE_VERSION)/buildroot-config os-base/config/amd64/buildroot-config
	cp config/os-base/$(OS_BASE_VERSION)/Dockerfile.dapper os-base/
	make -C os-base


