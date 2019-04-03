#!/bin/bash --login
# Script for reset and initialization Topological inventory database
#
# NOTE: Edit your variables below
source config.sh
source init-common.sh

cd $root_dir

cd topological_inventory-core
bundle exec rake db:setup

cd ../topological_inventory-api
bundle exec rake db:seed

cd ../source-api
bundle exec rake db:migrate
bundle exec rake db:seed

echo "Setting Openshift Source to: $OPENSHIFT_SOURCE_UID"
rails r "Source.create(:name => 'OpenShift Source', :tenant => Tenant.create(:external_tenant => '123', :uid =>'"$OPENSHIFT_SOURCE_UID"', :source_type => SourceType.find_by(:name => 'openshift'))"


echo "Setting Amazon Source to: $AMAZON_SOURCE_UID"
rails r "Source.create(:name => 'Amazon Source', :tenant => Tenant.where(:external_tenant => '123').first, :uid =>'"$AMAZON_SOURCE_UID"', :source_type => SourceType.find_by(:name => 'amazon'))"

echo "Setting AnsibleTower Source to: $ANSIBLE_TOWER_SOURCE_UID"
rails r "Source.create(:name => 'Ansible Tower Source', :tenant => Tenant.where(:external_tenant => '123').first, :uid => '"$ANSIBLE_TOWER_SOURCE_UID"', :source_type => SourceType.find_by(:name => 'ansible-tower'))"

