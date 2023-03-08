# Dockerized build for Mobian Linux kernels

## Synopsis

A set of Docker goods for building Mobian's Linux kernels, starting with
[rockchip-linux](https://salsa.debian.org/Mobian-team/devices/kernels/rockchip-linux/).  Created to solve the case where
[the cross-build mechanism](https://wiki.debian.org/Teams/Mobian/KernelBuild) is insufficient for a host, e.g. where
cross-build packages conflict with other required packages for the host.

See `build-rockchip-linux.sh` for build steps.

## Use
```sh
git submodule init
DEBIAN_VERSION=bookworm sh -c 'docker-compose --file mobian-linux.docker-compose.yml build --build-arg DEBIAN_VERSION=${DEBIAN_VERSION}'
DEBIAN_VERSION=bookworm docker-compose --file mobian-linux.docker-compose.yml run --rm rockchip-linux
```

## Customize
The `build-rockchip-linux.sh` script can be customized or avoided, but using a different entrypoint to the container:
```sh
DEBIAN_VERSION=bookworm docker-compose --file mobian-linux.docker-compose.yml run --rm --entrypoint bash rockchip-linux
```
