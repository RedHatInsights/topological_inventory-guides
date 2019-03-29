#!/bin/bash --login
# Usage ./openshift-operations.sh
echo "Starting Openshift Operations worker"
source config.sh
source init-common.sh

export PATH_PREFIX="/api"

cd $OPENSHIFT_DIR

bin/openshift-operations 

