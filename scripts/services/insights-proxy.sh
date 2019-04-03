#!/bin/bash --login

source config.sh
source init-common.sh

echo "Starting insights proxy"

cd "$INSIGHTS_CHROME_DIR/build"
SPANDX_CONFIG=$TOPOLOGICAL_INVENTORY_UI_DIR/config/spandx.config.js LOCAL_CHROME=true bash "$INSIGHTS_PROXY_DIR/scripts/run.sh"