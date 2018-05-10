#!/usr/bin/env bash
pushd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null
SCRIPTS_DIR="$( pwd )"
source $SCRIPTS_DIR/avs-config.sh

if [[ -e $SCRIPTS_DIR/AlexaClientSDKConfig.json ]]; then
    while true; do
        read -p "Use authorisation details found in $SCRIPTS_DIR/AlexaClientSDKConfig.json (y/n)? " ANSWER
        case ${ANSWER} in
            y|Y|yes|YES )
                cp $SCRIPTS_DIR/AlexaClientSDKConfig.json $SDK_BUILD/Integration/AlexaClientSDKConfig.json
                break;;
            n|N|no|NO )
                source $SCRIPTS_DIR/avs-userinput.sh
                envsubst < $SDK_SRC/Integration/AlexaClientSDKConfig.json > $SDK_BUILD/Integration/AlexaClientSDKConfig.json
                break;;
        esac
    done
else
    source $SCRIPTS_DIR/avs-userinput.sh
    envsubst < $SDK_SRC/Integration/AlexaClientSDKConfig.json > $SDK_BUILD/Integration/AlexaClientSDKConfig.json
fi


# Take a backup
cp $SDK_BUILD/Integration/AlexaClientSDKConfig.json $SCRIPTS_DIR/

source $SCRIPTS_DIR/avs-autostart.sh

pushd $SDK_BUILD > /dev/null
sudo fuser -k -TERM -n tcp 3000
python AuthServer/AuthServer.py | grep -v '400' &
chromium-browser http://localhost:3000 > /dev/null 2>&1
wait
popd > /dev/null

echo
echo "Auth details stored in $SDK_BUILD/Integration/AlexaClientSDKConfig.json"

popd > /dev/null
