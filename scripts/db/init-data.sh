#!/usr/bin/env bash

source config.sh
source init-common.sh

cd ${TOPOLOGICAL_API_DIR}
echo "Creating Tenants"
rails r "Tenant.first_or_create!(:external_tenant => '$MY_GITHUB_NAME')"

cd ${SOURCES_API_DIR}
rails r "Tenant.first_or_create!(:name => '$MY_GITHUB_NAME', :external_tenant => '$MY_GITHUB_NAME')"
# sources-sync tenant hardcoded in topological_inventory-sync/lib/topological_inventory/sync/sources_sync_worker.rb:77
rails r "Tenant.first_or_create!(:name => 'Tp-Inv Sources Sync service', :external_tenant => 'topological_inventory-sources_sync')"

echo "Creating Mock Source Type"
rails r "SourceType.first_or_create!(:name => 'mock-source', :product_name => 'Mock', :vendor => 'Red Hat')"

echo "Setting Mock Source to: $MOCK_SOURCE_UID"
rails r "Source.first_or_create!(:name => 'Mock Source', :tenant => Tenant.where(:external_tenant => '$MY_GITHUB_NAME').first, :uid =>'$MOCK_SOURCE_UID', :source_type => SourceType.find_by(:name => 'mock-source'))"

echo "Setting Openshift Source to: $OPENSHIFT_SOURCE_UID"
rails r "Source.first_or_create!(:name => 'OpenShift Source', :tenant => Tenant.where(:external_tenant => '$MY_GITHUB_NAME').first, :uid =>'$OPENSHIFT_SOURCE_UID', :source_type => SourceType.find_by(:name => 'openshift'))"

echo "Setting Amazon Source to: $AMAZON_SOURCE_UID"
rails r "Source.first_or_create!(:name => 'Amazon Source', :tenant => Tenant.where(:external_tenant => '$MY_GITHUB_NAME').first, :uid =>'$AMAZON_SOURCE_UID', :source_type => SourceType.find_by(:name => 'amazon'))"

echo "Setting AnsibleTower Source to: $ANSIBLE_TOWER_SOURCE_UID"
rails r "Source.first_or_create!(:name => 'Ansible Tower Source', :tenant => Tenant.where(:external_tenant => '$MY_GITHUB_NAME').first, :uid => '$ANSIBLE_TOWER_SOURCE_UID', :source_type => SourceType.find_by(:name => 'ansible-tower'))"
