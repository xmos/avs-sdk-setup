#!/usr/bin/env bash
pushd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null
SCRIPTS_DIR="$( pwd )"
source $SCRIPTS_DIR/avs-config.sh

AUTOSTART_SESSION="avsrun"
STARTUP_SCRIPT=$SDK_FOLDER/avsrun-startup.sh
echo "#!/bin/bash" > $STARTUP_SCRIPT
echo "LD_LIBRARY_PATH=$SDK_BUILD/lib:$LD_LIBRARY_PATH TZ=UTC $SDK_BUILD/SampleApp/src/SampleApp $SDK_BUILD/Integration/AlexaClientSDKConfig.json $SDK_BUILD/models" >> $STARTUP_SCRIPT
echo "\$SHELL" >> $STARTUP_SCRIPT
chmod a+rx $STARTUP_SCRIPT


AUTOSTART=$HOME/.config/lxsession/LXDE-pi/autostart

while true; do
    read -p "Automatically run AVS SDK at startup (y/n)? " ANSWER
    case ${ANSWER} in
        n|N|no|NO )
            grep $AUTOSTART_SESSION $AUTOSTART > /dev/null 2>&1
            if [ $? == 0 ]; then
                # Remove startup script from autostart file
                sed -i '/'"$AUTOSTART_SESSION"'/d' $AUTOSTART
            fi
            break;;
        y|Y|yes|YES )
            grep $AUTOSTART_SESSION $AUTOSTART > /dev/null 2>&1
            if [ $? != 0 ]; then
                # Append startup script if not already in autostart file
                echo "@lxterminal -t $AUTOSTART_SESSION --geometry=150x50 -e $STARTUP_SCRIPT" >> $AUTOSTART
            fi
            break;;
    esac
done

popd > /dev/null
