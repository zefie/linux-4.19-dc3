#!/bin/bash
PWD=$(realpath "$(dirname "${0}")/../")
cd "${PWD}"

export ARCH=arm
CONCURRENCY_LEVEL=7
REVISION=1.1
VERSION="-dc3"
CROSS="arm-linux-gnueabihf-"

rm -rf debian/
make mrproper
make dreamcatcher3_zefie_defconfig

DEB_HOST_ARCH=armhf make-kpkg \
--rootcmd fakeroot --arch ${ARCH} --initrd --jobs ${CONCURRENCY_LEVEL} \
--append-to-version="${VERSION}" --revision="${REVISION}" \
--us --uc --cross-compile "${CROSS}" \
kernel_image kernel_headers
