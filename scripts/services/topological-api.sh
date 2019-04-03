#!/bin/bash --login
echo "Starting Topological Inventory API"
source config.sh
source init-common.sh

cd $TOPOLOGICAL_API_DIR
env PORT=$TOPOLOGICAL_INVENTORY_API_SERVICE_PORT rails s

