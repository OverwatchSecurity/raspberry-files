#!/bin/sh
#
# Usage: pack_kernel.sh <kernel dir> <destination dir>

set -e

mkdir $2
(cd $1; find . -name Makefile\* -o -name Kconfig\* -o -name \*.pl) > "packfiles"
(cd $1; find arch/arm/include include scripts -type f) >> "packfiles"
(cd $1; find arch/arm -name module.lds -o -name Kbuild.platforms -o -name Platform) >> "packfiles"
(cd $1; find $(find arch/arm -name include -o -name scripts -type d) -type f) >> "packfiles"
(cd $1; find arch/arm/include Module.symvers include scripts -type f) >> "packfiles"

(cd $1; tar -c -f - -T -) < "packfiles" | (cd $2; tar -xf -)

(cd $1; cp .config $2/.config)

rm "packfiles"
