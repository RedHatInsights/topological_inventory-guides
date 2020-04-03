#!/bin/bash --login

echo "Starting Topological Inventory Sources Sync"
source config.sh
source init-common.sh

cd ${TOPOLOGICAL_INVENTORY_SYNC_DIR}
bin/topological-inventory-sources-sync
