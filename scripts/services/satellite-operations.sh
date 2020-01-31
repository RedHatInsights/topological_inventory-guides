#!/bin/bash --login
# Usage ./satellite-operations.sh
echo "Starting Satellite Operations worker"
source config.sh
source init-common.sh

cd ${SATELLITE_DIR}

# No args, used ENV vars:

# - QUEUE_HOST + QUEUE_PORT (path to kafka)
# - SOURCES_SCHEME + SOURCES_HOST + SOURCES_PORT (path to Sources API svc)
bin/satellite-operations

