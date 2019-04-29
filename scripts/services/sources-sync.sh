#!/bin/bash --login

echo "Starting Topological Inventory Sources Sync"
source config.sh
source init-common.sh

cd ${TOPOLOGICAL_INVENTORY_SOURCES_SYNC_DIR}
bin/setup
bin/topological-inventory-sources-sync
