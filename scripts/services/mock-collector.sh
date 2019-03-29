#!/bin/bash --login
echo "Starting Mock source collector"
source config.sh
source init-common.sh

cd $MOCK_SOURCE_DIR 
bin/openshift-mock-collector --source $MOCK_SOURCE_UID --config $MOCK_SOURCE_CONFIG --amount $MOCK_SOURCE_AMOUNTS

