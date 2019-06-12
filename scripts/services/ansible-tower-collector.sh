#!/bin/bash --login
echo "Starting Amazon collector"
source config.sh
source init-common.sh

cd $ANSIBLE_TOWER_DIR

bin/ansible_tower-collector --source $ANSIBLE_TOWER_SOURCE_UID --scheme $ANSIBLE_TOWER_SCHEME --host $ANSIBLE_TOWER_HOST --user $ANSIBLE_TOWER_USER --password $ANSIBLE_TOWER_PASSWORD --metrics-port $METRICS_PORT
