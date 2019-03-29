#!/bin/bash --login
echo "Starting Topological Inventory API"
source config.sh
source init-common.sh

cd $TOPOLOGICAL_API_DIR
rails s

