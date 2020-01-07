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
rails r "SourceType.find_or_create_by(:name => 'mock-source', :product_name => 'Mock', :vendor => 'Red Hat')"

echo "Setting Mock Source to: $MOCK_SOURCE_UID"
rails r "Source.find_or_create_by(:name => 'Mock Source', :tenant => Tenant.where(:external_tenant => '$MY_GITHUB_NAME').first, :uid =>'$MOCK_SOURCE_UID', :source_type => SourceType.find_by(:name => 'mock-source'), :availability_status => 'available')"

# Token(Password) has to be added manually!
echo "Setting Openshift Source to: $OPENSHIFT_SOURCE_UID"
rails r "tenant = Tenant.where(:external_tenant => '$MY_GITHUB_NAME').first
src = Source.find_or_create_by(:name => 'OpenShift Source', :tenant => tenant, :uid =>'$OPENSHIFT_SOURCE_UID', :source_type => SourceType.find_by(:name => 'openshift'), :availability_status => 'available')
endpoint = Endpoint.find_or_create_by(:source_id => src.id, :port => $OPENSHIFT_PORT, :default => true, :scheme => '$OPENSHIFT_SCHEME', :host => '$OPENSHIFT_HOST', :path => '/', :tenant => tenant)
auth = Authentication.find_or_create_by(:resource_type => 'Endpoint', :resource_id => endpoint.id, :authtype => 'token', :password =>'xxx', :tenant => tenant)
app_type = ApplicationType.where(:name => '/insights/platform/topological-inventory').first
app = Application.find_or_create_by(:source => src, :tenant => tenant, :application_type => app_type, :availability_status => 'available')"


echo "Setting Amazon Source to: $AMAZON_SOURCE_UID"
rails r "tenant = Tenant.where(:external_tenant => '$MY_GITHUB_NAME').first
src = Source.find_or_create_by(:name => 'Amazon Source', :tenant => tenant, :uid =>'$AMAZON_SOURCE_UID', :source_type => SourceType.find_by(:name => 'amazon'), :availability_status => 'available')
endpoint = Endpoint.find_or_create_by(:source_id => src.id, :default => true, :path => '/', :tenant => tenant)
auth = Authentication.find_or_create_by(:resource_type => 'Endpoint', :resource_id => endpoint.id, :authtype => 'access_key_secret_key', :username => '$AMAZON_ACCESS_KEY_ID', :password => '$AMAZON_SECRET_ACCESS_KEY', :tenant => tenant)
app_type = ApplicationType.where(:name => '/insights/platform/topological-inventory').first
app = Application.find_or_create_by(:source => src, :tenant => tenant, :application_type => app_type, :availability_status => 'available')"

echo "Setting AnsibleTower Source to: $ANSIBLE_TOWER_SOURCE_UID"
rails r "tenant = Tenant.where(:external_tenant => '$MY_GITHUB_NAME').first
src = Source.find_or_create_by(:name => 'Ansible Tower Source', :tenant => tenant, :uid => '$ANSIBLE_TOWER_SOURCE_UID', :source_type => SourceType.find_by(:name => 'ansible-tower'), :availability_status => 'available')
endpoint = Endpoint.find_or_create_by(:source_id => src.id, :role => 'ansible', :default => true, :scheme => '$ANSIBLE_TOWER_SCHEME', :host => '$ANSIBLE_TOWER_HOST', :path => '/', :tenant => tenant)
auth = Authentication.find_or_create_by(:resource_type => 'Endpoint', :resource_id => endpoint.id, :authtype => 'username_password', :username => '$ANSIBLE_TOWER_USER', :password => '$ANSIBLE_TOWER_PASSWORD', :tenant => tenant)
app_type = ApplicationType.where(:name => '/insights/platform/topological-inventory').first
app = Application.find_or_create_by(:source => src, :tenant => tenant, :application_type => app_type, :availability_status => 'available')"

echo "Setting Azure Source to: $AZURE_SOURCE_UID"
rails r "tenant = Tenant.where(:external_tenant => '$MY_GITHUB_NAME').first
src = Source.find_or_create_by(:name => 'Azure Source', :tenant => tenant, :uid =>'$AZURE_SOURCE_UID', :source_type => SourceType.find_by(:name => 'azure'), :availability_status => 'available')
endpoint = Endpoint.find_or_create_by(:source_id => src.id, :default => true, :path => '/', :tenant => tenant)
auth = Authentication.find_or_create_by(:resource_type => 'Endpoint', :resource_id => endpoint.id, :authtype => 'tenant_id_client_id_client_secret', :username => '$AZURE_CLIENT_ID', :password => '$AZURE_CLIENT_SECRET', :extra => {\"azure\": {\"tenant_id\": \"$AZURE_SUBSCRIPTION_ID\"}}, :tenant => tenant)
app_type = ApplicationType.where(:name => '/insights/platform/topological-inventory').first
app = Application.find_or_create_by(:source => src, :tenant => tenant, :application_type => app_type, :availability_status => 'available')"


echo "-- Done! You can find these UID values in config.sh --"
