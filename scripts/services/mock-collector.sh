#!/bin/bash --login
echo "Starting Mock source collector"
source config.sh
source init-common.sh

cd $MOCK_SOURCE_DIR 
bin/mock-collector --source $MOCK_SOURCE_UID --config $MOCK_SOURCE_CONFIG --amounts $MOCK_SOURCE_AMOUNTS

