#!/usr/bin/env bash

# Setup paths
SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $SCRIPTS_DIR/avs-config.sh

cd $SDK_BUILD
make -j2
