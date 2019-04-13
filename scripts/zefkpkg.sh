#!/bin/bash
PWD=$(realpath "$(dirname "${0}")/../")
cd "${PWD}"

export ARCH=arm
CONCURRENCY_LEVEL=7
REVISION=1.3
VERSION="-dc3"
#CROSS="arm-linux-gnueabihf-"
CROSS="/home/zefie/dev/ubertc/out/arm-eabi-6.x/bin/arm-eabi-"
DT="sun5i-a13-dreamcatcher"
DEFCONFIG="dreamcatcher3_zefie_defconfig"

if [ -z "${1}" ]; then
	rm -rf debian/
	make mrproper
	make "${DEFCONFIG}"

	make-kpkg --arch armhf \
		--rootcmd fakeroot --initrd --jobs ${CONCURRENCY_LEVEL} \
		--append-to-version="${VERSION}" --revision="${REVISION}" \
		--uImage --us --uc --cross-compile "${CROSS}" \
		kernel_image kernel_headers

	cp -v "arch/${ARCH}/boot/dts/${DT}.dtb" ..
else
	export CROSS_COMPILE="${CROSS}"
	export LOCAL_VERSION="-dc3"
	case "${1}" in
		"clean")
			rm -rf debian/
			make mrproper
			;;

		"savedefconfig")
			make savedefconfig
			mv -v defconfig "arch/${ARCH}/configs/${DEFCONFIG}"
			;;

		"getdefconfig")
			make "${DEFCONFIG}"
			;;

		"cleanconfig")
			make "${DEFCONFIG}"
			make menuconfig
			;;

		"config")
			make menuconfig
			;;
		*)
			"${@}"
			;;
	esac
fi
