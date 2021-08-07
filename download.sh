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

DOWNLOAD_URL="https://build.lolinet.com/file/lineage/anbox_${ARCH}/latest-raw-images.zip"

rm -rf downloaded_artifacts
mkdir -p downloaded_artifacts

wget "${DOWNLOAD_URL}"
unzip latest-raw-images.zip -d "${PWD}/downloaded_artifacts"
rm -rf latest-raw-images.zip
