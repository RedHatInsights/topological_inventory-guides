#!/usr/bin/env bash

source config.sh
source init-common.sh

cd ${TOPOLOGICAL_API_DIR}
echo "Db:Seed..."
bundle exec rake db:seed
cd ${SOURCES_API_DIR}
bundle exec rake db:seed

cd ${TOPOLOGICAL_API_DIR}
echo "Creating Tenants"
rails r "Tenant.find_or_create_by(:external_tenant => '$MY_GITHUB_NAME')"
rails r "Tenant.find_or_create_by(:external_tenant => 'system_orchestrator')"

cd ${SOURCES_API_DIR}
rails r "Tenant.find_or_create_by(:name => '$MY_GITHUB_NAME', :external_tenant => '$MY_GITHUB_NAME')"
# sources-sync tenant hardcoded in topological_inventory-sync/lib/topological_inventory/sync/sources_sync_worker.rb:77
rails r "Tenant.find_or_create_by(:name => 'Tp-Inv Sources Sync service', :external_tenant => 'topological_inventory-sources_sync')"
rails r "Tenant.find_or_create_by(:name => 'Orchestrator', :external_tenant => 'system_orchestrator')"

echo "Creating Mock Source Type"
rails r "SourceType.find_or_create_by(:name => 'mock-source', :product_name => 'Mock', :vendor => 'Red Hat', :schema => {})"

echo "Setting Mock Source to: $MOCK_SOURCE_UID"
rails r "Source.find_or_create_by(:name => 'Mock Source', :tenant => Tenant.where(:external_tenant => '$MY_GITHUB_NAME').first, :uid =>'$MOCK_SOURCE_UID', :source_type => SourceType.find_by(:name => 'mock-source'))"

echo "Setting Openshift Source to: $OPENSHIFT_SOURCE_UID"
rails r "Source.find_or_create_by(:name => 'OpenShift Source', :tenant => Tenant.where(:external_tenant => '$MY_GITHUB_NAME').first, :uid =>'$OPENSHIFT_SOURCE_UID', :source_type => SourceType.find_by(:name => 'openshift'))"

echo "Setting Amazon Source to: $AMAZON_SOURCE_UID"
rails r "Source.find_or_create_by(:name => 'Amazon Source', :tenant => Tenant.where(:external_tenant => '$MY_GITHUB_NAME').first, :uid =>'$AMAZON_SOURCE_UID', :source_type => SourceType.find_by(:name => 'amazon'))"

echo "Setting AnsibleTower Source to: $ANSIBLE_TOWER_SOURCE_UID"
rails r "Source.find_or_create_by(:name => 'Ansible Tower Source', :tenant => Tenant.where(:external_tenant => '$MY_GITHUB_NAME').first, :uid => '$ANSIBLE_TOWER_SOURCE_UID', :source_type => SourceType.find_by(:name => 'ansible-tower'))"

echo "Setting Azure Source to: $AZURE_SOURCE_UID"
rails r "source = Source.find_or_create_by(:name => 'Azure Source', :tenant => Tenant.where(:external_tenant => '$MY_GITHUB_NAME').first, :uid =>'$AZURE_SOURCE_UID', :source_type => SourceType.find_by(:name => 'azure'))"

echo "-- Done! You can find these UID values in config.sh --"
