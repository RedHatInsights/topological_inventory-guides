#!/bin/bash --login
echo "Starting Topological Inventory API"
source config.sh
source init-common.sh

cd $SOURCES_API_DIR
env PORT=$SOURCES_API_SERVICE_PORT rails s

