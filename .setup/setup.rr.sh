#!/bin/sh

ROADRUNNER_ARCH=$(uname -m)
ROADRUNNER_VERSION="2023.2.2"

if [ "${ROADRUNNER_ARCH}" == "x86_64" ]; then
    ROADRUNNER_ARCH="amd64"
fi

if [ "${ROADRUNNER_ARCH}" == "aarch64" ]; then
    ROADRUNNER_ARCH="arm64"
fi

TARGET="roadrunner-${ROADRUNNER_VERSION}-linux-${ROADRUNNER_ARCH}"

wget -O rr.tar.gz https://github.com/roadrunner-server/roadrunner/releases/download/v${ROADRUNNER_VERSION}/${TARGET}.tar.gz
tar -xzvf rr.tar.gz

mv ${TARGET}/rr /usr/bin/rr

rm -rf ${TARGET}
rm rr.tar.gz
