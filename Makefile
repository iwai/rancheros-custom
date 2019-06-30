MAKEFLAGS    += --warn-undefined-variables
SHELL        := /bin/bash
.SHELLFLAGS  := -eu -o pipefail -c

OS_VERSION      ?= 1.5.2
OS_BASE_VERSION ?= v2018.02.11-1

ARTIFACTS = os-base/dist/artifacts
TARGET    = os-base_amd64.tar.xz

OS_BASE_URL_amd64 = https://github.com/iwai/rancheros-custom/releases/download/v$(OS_VERSION)/os-base_amd64.tar.xz


$(ARTIFACTS)/$(TARGET) $(ARTIFACTS)/$(TARGET).busybox-dynamic.config $(ARTIFACTS)/$(TARGET).config:
	cp config/os-base/$(OS_BASE_VERSION)/buildroot-config os-base/config/amd64/buildroot-config
	cp config/os-base/$(OS_BASE_VERSION)/Dockerfile.dapper os-base/
	make -C os-base/

build-os-base: $(ARTIFACTS)/$(TARGET) $(ARTIFACTS)/$(TARGET).busybox-dynamic.config $(ARTIFACTS)/$(TARGET).config

release-os-base: build-os-base
	hub release create -a $(ARTIFACTS)/$(TARGET) \
	  -a $(ARTIFACTS)/$(TARGET).busybox-dynamic.config \
	  -a $(ARTIFACTS)/$(TARGET).config \
	  v$(OS_VERSION)

os/dist/artifacts/rancheros.iso os/dist/artifacts/rootfs.tar.gz:
#	cp config/os/v$(OS_VERSION)/Dockerfile.dapper os/
	OS_BASE_URL_amd64=$(OS_BASE_URL_amd64) make -C os/

build-os: os/dist/artifacts/rancheros.iso os/dist/artifacts/rootfs.tar.gz

release-os: os/dist/artifacts/rancheros.iso os/dist/artifacts/rootfs.tar.gz
	hub release edit -a os/dist/artifacts/rancheros.iso \
	  -a os/dist/artifacts/rootfs.tar.gz \
	  v$(OS_VERSION)

os-packer/dist/rancheros-digitalocean.img: os/dist/artifacts/rancheros.iso
	cp os/dist/artifacts/rancheros.iso os-packer/assets/
	cp config/os-packer/digitalocean/digitalocean-qemu.json os-packer/digitalocean/
	PACKER_BOOT_WAIT=180s RANCHEROS_VERSION=v$(OS_VERSION) make build-digitalocean -C os-packer/

build-digitalocean: os-packer/dist/rancheros-digitalocean.img

release-digitalocean:
	hub release edit -a os-packer/dist/rancheros-digitalocean.img \
	  v$(OS_VERSION)

clean:
	-rm -r os-base/dist/*
	-rm -r os/dist/*
	-rm -r os-packer/dist/*
