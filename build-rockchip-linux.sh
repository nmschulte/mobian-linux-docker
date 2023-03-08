#!/usr/bin/env bash

# This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public
# License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# # This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# # You should have received a copy of the GNU General Public License along with this program. If not, see
# <https://www.gnu.org/licenses/>. 

# build-rockchip-linux.sh --

# TODO(nms): configurable/parameterized git user config
# TODO(nms): configurable/parameterized KERNELRELEASE and KDEB_PKGVERSION
# TODO(nms): configurable/parameterized make --jobs #

#git config user.name 'Nathan Schulte'
#git config user.email 'nmschulte@desmas.net'

gbp pq import
#gbp pq apply --topic keyboard ../megous-ppkb-6.1.patch

ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make rockchip_defconfig
#ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make menuconfig
#./scripts/config --module PPKB_POWER_MANAGER
ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make olddefconfig

ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make -j16 bindeb-pkg KERNELRELEASE="6.1-rockchip-ppkb" KDEB_PKGVERSION="1"
