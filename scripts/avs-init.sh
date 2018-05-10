#!/usr/bin/env bash
pushd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null
SCRIPTS_DIR="$( pwd )"
source $SCRIPTS_DIR/avs-config.sh

ALIASES=$HOME/.bash_aliases
echo "export PATH=$SDK_BUILD/bin:$PATH" > $ALIASES
echo "export PKG_CONFIG_PATH=$SDK_BUILD/lib/pkgconfig:$PKG_CONFIG_PATH" >> $ALIASES
echo "alias avsmake=\"cd ~ && . $SCRIPTS_DIR/../setup.sh\"" >>  $ALIASES
echo "alias avsrun=\"LD_LIBRARY_PATH=$SDK_BUILD/lib:$LD_LIBRARY_PATH TZ=UTC $SDK_BUILD/SampleApp/src/SampleApp $SDK_BUILD/Integration/AlexaClientSDKConfig.json $SDK_BUILD/models\"" >> $ALIASES
echo "alias avsunit=\"LD_LIBRARY_PATH=$SDK_BUILD/lib:$LD_LIBRARY_PATH pushd $SDK_BUILD && sudo make all test && popd\"" >> $ALIASES
echo "alias avsintegration=\"LD_LIBRARY_PATH=$SDK_BUILD/lib:$LD_LIBRARY_PATH pushd $SDK_BUILD && sudo make all integration && popd\"" >> $ALIASES
echo "alias avsauth=\". $SCRIPTS_DIR/avs-pyauth.sh\"" >>  $ALIASES
echo "echo \"Available AVS aliases:\"" >> $ALIASES
echo "echo -e \"\tavsmake, avsrun, avsunit, avsintegration, avsauth\"" >> $ALIASES
echo "echo \"If authentication fails, please check $SDK_BUILD/Integration/AlexaClientSDKConfig.json\"" >> $ALIASES
echo "echo \"remove .bash_aliases and open a new terminal to remove bindings\"" >> $ALIASES

popd > /dev/null
