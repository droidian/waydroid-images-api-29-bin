#!/bin/bash -x

set -e

SUPPORTED_ARCHS="x86_64 aarch64 armv8l"
UNAME_ARCH=`uname -m`

for a in $SUPPORTED_ARCHS; do
    if [ $UNAME_ARCH == $a ]; then
        ARCH=$a
    fi
done
if [ -z ${ARCH} ]; then
    echo "ERROR: Your system with arch $UNAME_ARCH is not supported"
    exit
fi
if [ $UNAME_ARCH == "aarch64" ]; then
    ARCH="arm64"
fi
if [ $UNAME_ARCH == "armv8l" ]; then
    ARCH="arm64"
fi
if [ $UNAME_ARCH == "armv7l" ]; then
    ARCH="arm"
fi
if [ $UNAME_ARCH == "i386" ]; then
    ARCH="x86"
fi
if [ $UNAME_ARCH == "i686" ]; then
    ARCH="x86"
fi

SYSTEM_DOWNLOAD_URL=`python3 getlatest.py system ${ARCH}`
VENDOR9_DOWNLOAD_URL=`python3 getlatest.py vendor ${ARCH} HALIUM_9`
VENDOR10_DOWNLOAD_URL=`python3 getlatest.py vendor ${ARCH} HALIUM_10`
VENDOR11_DOWNLOAD_URL=`python3 getlatest.py vendor ${ARCH} HALIUM_11`

rm -rf downloaded_artifacts
mkdir -p downloaded_artifacts/halium9
mkdir -p downloaded_artifacts/halium10
mkdir -p downloaded_artifacts/halium11
mkdir -p downloaded_artifacts/system

wget "${SYSTEM_DOWNLOAD_URL}" -O system.zip
wget "${VENDOR9_DOWNLOAD_URL}" -O vendor9.zip
wget "${VENDOR10_DOWNLOAD_URL}" -O vendor10.zip
wget "${VENDOR11_DOWNLOAD_URL}" -O vendor11.zip

unzip system.zip -d "${PWD}/downloaded_artifacts/system"
unzip vendor9.zip -d "${PWD}/downloaded_artifacts/halium9"
unzip vendor10.zip -d "${PWD}/downloaded_artifacts/halium10"
unzip vendor11.zip -d "${PWD}/downloaded_artifacts/halium11"

rm system.zip vendor9.zip vendor10.zip vendor11.zip
