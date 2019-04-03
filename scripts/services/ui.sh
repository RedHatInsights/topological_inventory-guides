#!/bin/bash --login

source config.sh
source init-common.sh

echo "Starting UI"

cd $TOPOLOGICAL_INVENTORY_UI_DIR
BASE_PATH=$TOPOLOGICAL_INVENTORY_API_SERVICE_HOST:$TOPOLOGICAL_INVENTORY_API_SERVICE_PORT/api/ npm run start
