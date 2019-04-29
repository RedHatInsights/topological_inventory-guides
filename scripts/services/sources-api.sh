#!/bin/bash --login
echo "Starting Sources API"
source config.sh
source init-common.sh

cd ${SOURCES_API_DIR}
env PORT=${SOURCES_PORT} PATH_PREFIX="api" APP_NAME="sources" rails s

