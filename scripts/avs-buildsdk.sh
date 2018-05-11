#!/usr/bin/env bash
# Setup paths
pushd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null
SCRIPTS_DIR="$( pwd )"
source $SCRIPTS_DIR/avs-config.sh

pushd $SDK_BUILD > /dev/null
make -j2
popd > /dev/null

popd > /dev/null
