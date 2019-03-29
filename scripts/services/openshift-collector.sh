#!/bin/bash --login
echo "Starting Openshift collector"
source config.sh
source init-common.sh

cd $OPENSHIFT_DIR

oc login -u $OPENSHIFT_USER -p $OPENSHIFT_PASSWORD $OPENSHIFT_HOST:$OPENSHIFT_PORT; 
export OPENSHIFT_TOKEN=$(oc sa get-token -n management-infra management-admin)

./bin/openshift-collector --source $OPENSHIFT_SOURCE_UID --scheme $OPENSHIFT_SCHEME --host $OPENSHIFT_HOST --port $OPENSHIFT_PORT --token $OPENSHIFT_TOKEN --path $OPENSHIFT_API_PATH


