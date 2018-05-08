#!/usr/bin/env bash
SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $SCRIPTS_DIR/avs-config.sh

cd $SDK_BUILD
cmake $SDK_SRC \
  -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
  -DSENSORY_KEY_WORD_DETECTOR=ON \
  -DSENSORY_KEY_WORD_DETECTOR_LIB_PATH=$THIRD_PARTY/alexa-rpi/lib/libsnsr.a \
  -DSENSORY_KEY_WORD_DETECTOR_INCLUDE_DIR=$THIRD_PARTY/alexa-rpi/include \
  -DGSTREAMER_MEDIA_PLAYER=ON \
  -DPORTAUDIO=ON \
  -DPORTAUDIO_LIB_PATH=$THIRD_PARTY/portaudio/lib/.libs/libportaudio.a \
  -DPORTAUDIO_INCLUDE_DIR=$THIRD_PARTY/portaudio/include
