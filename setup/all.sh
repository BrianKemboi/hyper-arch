#!/usr/bin/env bash
set -eEo pipefail

SETUP_DIR=$INSTALL_DIR/setup

source $SETUP_DIR/yay.sh
source $SETUP_DIR/identification.sh
source $SETUP_DIR/terminal.sh
source $SETUP_DIR/config.sh
source $SETUP_DIR/bluetooth.sh
source $SETUP_DIR/desktop.sh
source $SETUP_DIR/development.sh
source $SETUP_DIR/docker.sh
source $SETUP_DIR/fonts.sh
source $SETUP_DIR/hyperland.sh
source $SETUP_DIR/mimetypes.sh
source $SETUP_DIR/nvim.sh