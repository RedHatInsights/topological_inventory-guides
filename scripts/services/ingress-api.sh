#!/bin/bash --login
echo "Starting Ingress API Server..."

source config.sh
source init-common.sh

cd $INGRESS_API_DIR
bundle exec rackup

