#!/bin/bash --login

source config.sh
source init-common.sh

echo "Starting insights chrome"

cd "$INSIGHTS_CHROME_DIR/build"
BASE_PATH=$TOPOLOGICAL_INVENTORY_API_SERVICE_HOST:$TOPOLOGICAL_INVENTORY_API_SERVICE_PORT/api/ npm run start
