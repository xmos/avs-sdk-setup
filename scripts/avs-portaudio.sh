#!/usr/bin/env bash

# Setup paths
SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $SCRIPTS_DIR/avs-config.sh

cd $THIRD_PARTY/*portaudio*/
./configure --without-jack
make -j3
