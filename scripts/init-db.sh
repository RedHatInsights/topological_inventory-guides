#!/bin/bash --login

source config.sh
source init-common

cwd=$(pwd)

cd "$root_dir/topological_inventory-api"

bundle exec rake db:create

cd $cwd
./reset-db.sh

