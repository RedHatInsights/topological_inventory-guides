#!/bin/bash --login

source config.sh
source init-common.sh

echo "Starting Persister"
cd $PERSISTER_DIR
bin/topological_inventory-persister

