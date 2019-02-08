#!/bin/bash --login
# Usage ./start-tp-inv.sh [--with_kafka]

source "$HOME/.rvm/scripts/rvm"
source config.sh

INGRESS_API_SVC_DIR="$root_dir/topological_inventory-ingress_api"
PERSISTER_SVC_DIR="$root_dir/topological_inventory-persister"

rvm use $rvm_ruby_version_tp_inv
rvm gemset use $rvm_gemset_name_tp_inv

./kafka.sh start

cd $INGRESS_API_SVC_DIR
bundle exec rackup &

echo "INGRESS API svc PID: $!"

cd $PERSISTER_SVC_DIR
bin/topological_inventory-persister &
echo "CORE svc PID: $!"

