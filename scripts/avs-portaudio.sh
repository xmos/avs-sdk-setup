#!/usr/bin/env bash
# Setup paths
pushd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null
SCRIPTS_DIR="$( pwd )"
source $SCRIPTS_DIR/avs-config.sh

pushd $THIRD_PARTY/*portaudio*/ > /dev/null
./configure --without-jack
make -j3
popd > /dev/null

popd > /dev/null
