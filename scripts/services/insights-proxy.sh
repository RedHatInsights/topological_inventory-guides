#!/bin/bash --login

source config.sh
source init-common.sh

echo "Starting insights proxy"

cd "$INSIGHTS_CHROME_DIR/build"
#SPANDX_CONFIG=$SOURCES_UI_DIR/config/spandx.config.js bash "$INSIGHTS_PROXY_DIR/scripts/run.sh"
SPANDX_CONFIG=${SPANDX_CONFIG_PATH} bash "$INSIGHTS_PROXY_DIR/scripts/run.sh"