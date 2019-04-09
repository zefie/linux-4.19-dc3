#!/bin/bash
PWD=$(realpath "$(dirname "${0}")/../")
cd "${PWD}"

export ARCH=arm
CONCURRENCY_LEVEL=7
REVISION=1.2
VERSION="-dc3"
#CROSS="arm-linux-gnueabihf-"
CROSS="/home/zefie/dev/ubertc/out/arm-eabi-6.x/bin/arm-eabi-"

rm -rf debian/
make mrproper
make dreamcatcher3_zefie_defconfig

make-kpkg --arch armhf \
--rootcmd fakeroot --initrd --jobs ${CONCURRENCY_LEVEL} \
--append-to-version="${VERSION}" --revision="${REVISION}" \
--us --uc --cross-compile "${CROSS}" \
kernel_image kernel_headers
