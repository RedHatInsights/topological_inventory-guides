#!/bin/bash --login
#
# NOTE: Edit your variables below
source config.sh

mkdir -p $root_dir
cd $root_dir

wget -O kafka.tgz $kafka_url
tar -xzf kafka.tgz
mv ./kafka_* ./kafka

chmod 744 ./*.sh
./clone-tp-inv.sh clone

rvm use $rvm_ruby_version_tp_inv
rvm gemset create $rvm_gemset_name_tp_inv
rvm gemset use $rvm_gemset_name_tp_inv

gem install bundler
./bundle-tp-inv.sh install

cd $root_dir
cd ./topological_inventory-api
cp config/database.dev.yml config/database.yml
cp config/database.dev.yml ../topological_inventory-core/config/database.yml
cp config/database.dev.yml ../topological_inventory-persister/config/database.yml
bundle exec rake db:create
cd ..

cd $root_dir
./reset-db-tp-inv.sh


