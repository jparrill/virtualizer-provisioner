#!/bin/bash

CONFIG_SRC=/opt/squid/squid.conf
CONFIG_VOL=squid-etc
CACHE_VOL=squid-cache
LOGS_VOL=squid-logs

podman volume create ${CACHE_VOL}
podman volume create ${LOGS_VOL}
podman volume create ${CONFIG_VOL}

PODMAN_CFG_PATH=$(podman volume inspect squid-etc | jq -c '.[0].Mountpoint' | tr -d '"')

podman create --name squid-transparent --restart always --net host -p 3129:3129 -p 3130:3130 -p 3131:3131 --volume ${LOGS_VOL}:/var/log/squid --volume ${CONFIG_VOL}:/etc/squid --volume ${CACHE_VOL}:/var/cache/squid -e SSL_RSA=2048 -e SSL_DAYS=3650 -e SSL_C=ES -e SSL_ST=Spain -e SSL_L=Madrid -e SSL_O=RedHat -e SSL_OU=Hypershift -e SSL_CERT=SquidCA -e TZ=Europe/Madrid docker.io/coun/squid-transparent:latest

cp ${CONFIG_SRC} ${PODMAN_CFG_PATH}
