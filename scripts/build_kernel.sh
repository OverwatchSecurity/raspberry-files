#!/bin/bash
#
# Usage: build_kernel.sh <kernel hash> <config filename> <tools directory> <kernel source destination>

set -e;
set -x;

if [ -d $4 ]; then
    echo "Kernel directory exists, it might already be built, exiting..."
    exit 0
fi

wget -q https://github.com/raspberrypi/linux/archive/$1.tar.gz
tar xzf $1.tar.gz
mv linux-$1 $4
rm $1.tar.gz

export CCPREFIX=$3/arm-bcm2708/arm-bcm2708-linux-gnueabi/bin/arm-bcm2708-linux-gnueabi-
export KERNEL_SRC=$4

cd $KERNEL_SRC
make mrproper

wget -q https://github.com/OverwatchSecurity/raspberry-files/raw/master/configs/$2 -O .config

make ARCH=arm CROSS_COMPILE=${CCPREFIX} oldconfig
make ARCH=arm CROSS_COMPILE=${CCPREFIX}
