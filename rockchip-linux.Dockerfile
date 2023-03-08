# Copyright © 2023 Nathan Schulte <nmschulte@desmas.net>

# This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public
# License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later
# version.

# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

# You should have received a copy of the GNU General Public License along with this program. If not, see
# <https://www.gnu.org/licenses/>. 

# rockchip-linux.Dockerfile --
# build rockchip-linux for Mobian, avoiding e.g. having to uninstall gcc-multilib

ARG DEBIAN_VERSION=bookworm
FROM debian:${DEBIAN_VERSION}

ARG MOBIAN_DIR=/mobian

WORKDIR ${MOBIAN_DIR}

RUN dpkg --add-architecture arm64 && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get --assume-yes dist-upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes g++-aarch64-linux-gnu \
    build-essential \
    crossbuild-essential-arm64 \
    git \
    tig \
    git-buildpackage \
    quilt \
    debootstrap \
    u-boot-tools \
    device-tree-compiler \
    libncurses-dev \
    flex \
    bison \
    libssl-dev \
    rsync \
    kmod \
    bc \
    cpio

RUN addgroup --gid 1000 mobian && \
    adduser --uid 1000 --ingroup mobian --home /home/mobian --shell /bin/sh --disabled-password --gecos "" mobian

WORKDIR ./mobian-linux/rockchip-linux

ENTRYPOINT ["bash", "../build-rockchip-linux.sh"]
