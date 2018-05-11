#!/usr/bin/env bash
# Setup paths
pushd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null
SCRIPTS_DIR="$( pwd )"
source $SCRIPTS_DIR/avs-config.sh

pushd $THIRD_PARTY > /dev/null
sudo chown -R $USER $SDK_BUILD

mkdir -p $SDK_BUILD/lib
mkdir -p $SDK_BUILD/include
mkdir -p $SDK_BUILD/models

cp alexa-rpi/lib/libsnsr.a $SDK_BUILD/lib
cp alexa-rpi/include/snsr.h $SDK_BUILD/include
cp alexa-rpi/models/spot-alexa-rpi-31000.snsr $SDK_BUILD/models
popd > /dev/null

popd > /dev/null
