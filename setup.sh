#!/usr/bin/env bash

SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"/scripts
source $SCRIPTS_DIR/avs-config.sh

SENSORY_MODEL_HASH_1=a8befe708af1aa80c32bce5219312a4ec439a0b0
SENSORY_MODEL_HASH_2=ddbc9040e24ed06aafe402017fa640b86d3520b3
SENSORY_MODEL_HASH_3=43b5cb246cb8422a8f39ae92d3e372dc19b98243

# Select Sensory version to use (default is 2)
SENSORY_MODEL_HASH=$SENSORY_MODEL_HASH_2

pushd . > /dev/null


mkdir -p $SOURCES_FOLDER
mkdir -p $SDK_BUILD
mkdir -p $THIRD_PARTY
mkdir -p $SOUND_FILES


# Set environment variables
source $SCRIPTS_DIR/avs-init.sh

# Clone sensory and complete license
if [ ! -d $THIRD_PARTY/alexa-rpi ]; then
    cd $THIRD_PARTY
    git clone git://github.com/Sensory/alexa-rpi.git
    cd alexa-rpi
    git checkout $SENSORY_MODEL_HASH -- models/spot-alexa-rpi-31000.snsr
fi
if [ -e $THIRD_PARTY/alexa-rpi/bin/license.sh ]; then
    bash $THIRD_PARTY/alexa-rpi/bin/license.sh
fi

TIMES_FILE=$SCRIPTS_DIR/time_taken.txt
SECONDS=0

$SCRIPTS_DIR/avs-getdepbin.sh | sed "s/^/[apt-get dependencies] /"
echo "apt-get deps: $SECONDS" > $TIMES_FILE
$SCRIPTS_DIR/avs-getdepsrc.sh | sed "s/^/[get sources] /"
echo "getsrc: $SECONDS" >> $TIMES_FILE
$SCRIPTS_DIR/avs-portaudio.sh | sed "s/^/[portaudio] /"
echo "portaudio: $SECONDS" >> $TIMES_FILE
$SCRIPTS_DIR/avs-sensory.sh | sed "s/^/[sensory] /"
echo "sensory: $SECONDS" >> $TIMES_FILE
$SCRIPTS_DIR/avs-getsdk.sh | sed "s/^/[sdk download] /"
echo "getsdk: $SECONDS" >> $TIMES_FILE
$SCRIPTS_DIR/avs-configsdk.sh | sed "s/^/[sdk config] /"
echo "configsdk: $SECONDS" >> $TIMES_FILE
$SCRIPTS_DIR/avs-buildsdk.sh | sed "s/^/[sdk build] /"
echo "buildsdk: $SECONDS" >> $TIMES_FILE

echo "####~~~~BUILD TIMES~~~~####"
$SCRIPTS_DIR/convert_times.py $TIMES_FILE

$SCRIPTS_DIR/avs-pyauth.sh | sed "s/^/[authorisation] /"

popd > /dev/null

echo Available aliases:
echo +++ avsmake
echo +++ avsrun
echo +++ avsunit
echo +++ avsintegration
echo +++ avsauth
