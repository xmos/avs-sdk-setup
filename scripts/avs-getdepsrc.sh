#!/usr/bin/env bash
# Setup paths
pushd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null
SCRIPTS_DIR="$( pwd )"
source $SCRIPTS_DIR/avs-config.sh

pushd $THIRD_PARTY > /dev/null
wget -c http://www.portaudio.com/archives/pa_stable_v190600_20161030.tgz
tar zxf pa_stable_v190600_20161030.tgz
popd > /dev/null

popd > /dev/null
