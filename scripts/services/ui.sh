#!/bin/bash --login

source config.sh
source init-common.sh

echo "Starting UI"
echo "See https://ci.foo.redhat.com:1337/insights/settings/sources"

cd ${SOURCES_UI_DIR}
FAKE_IDENTITY=${MY_GITHUB_NAME} BASE_PATH=http://${SOURCES_HOST}:${SOURCES_PORT}/api npm run start
