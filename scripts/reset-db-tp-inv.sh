#!/bin/bash --login
# Script for reset and initialization Topological inventory database
#
# NOTE: Edit your variables below
source config.sh
source "$HOME/.rvm/scripts/rvm"

rvm use $rvm_ruby_version_tp_inv
rvm gemset use $rvm_gemset_name_tp_inv

cd $root_dir

cd topological_inventory-core
bundle exec rake db:setup

cd ../topological_inventory-api
bundle exec rake db:seed


openshift_uuid=31b5338b-685d-4056-ba39-d00b4d7f19cc
echo "Setting Openshift Source to: $openshift_uuid"
rails r "Source.create(:name => 'OpenShift Source', :tenant => Tenant.create, :uid =>'"$openshift_uuid"', :source_type => SourceType.find_by(:name => 'openshift'))"


amazon_uuid=592ba27a-2b89-11e9-b210-d663bd873d93
echo "Setting Amazon Source to: $amazon_uuid"
rails r "Source.create(:name => 'Amazon Source', :tenant => Tenant.create, :uid =>'"$amazon_uuid"', :source_type => SourceType.find_by(:name => 'amazon'))"


