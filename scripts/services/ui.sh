#!/bin/bash --login

source config.sh
source init-common.sh

echo "Starting UI"
echo "See https://ci.foo.redhat.com:1337/insights/settings/sources"

cd ${TOPOLOGICAL_INVENTORY_UI_DIR}
BASE_PATH=http://${SOURCES_HOST}:${SOURCES_PORT}/api npm run start
