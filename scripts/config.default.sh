#!/usr/bin/env bash
#
# Create config.sh and write into it:
# ```
# root_dir="<your_dir>"
# source config.default.sh
# ```

# You can redefine services started by default
# in your config.sh
# See start_by_default()
source repositories.sh

# Root directory for cloned repositories
# created by install script install.sh
if [[ -z ${root_dir} ]]; then
    echo "Please specify \$root_dir variable in config.sh"
    exit
fi

# Your Github account name used for cloning
export MY_GITHUB_NAME="" # https://github.com/<MY_GITHUB_NAME>/<repository name>

# Get Github API token there
# Needed for Github API requests, read only access is enough
# https://help.github.com/en/articles/creating-a-personal-access-token-for-the-command-line
export MY_GITHUB_TOKEN=""

# Variable for HTTP request header x-rh-identity.
# Requests authenticated against Tenant.external_tenant
export X_RH_IDENTITY=$(echo "{\"identity\":{\"account_number\":\"${GITHUB_NAME}\"}}" | base64)

if [[ "$(uname)" == "Darwin" ]]; then
  export MAC_OS=true
else
  export MAC_OS=false
fi

# Kafka queue
# Get latest release URL at https://kafka.apache.org/quickstart
export KAFKA_INSTALL_URL="http://mirror.dkm.cz/apache/kafka/2.2.0/kafka_2.12-2.2.0.tgz"
# Directory below is created automatically by script install.sh
export KAFKA_DIR="$root_dir/kafka"
export QUEUE_HOST="localhost" # used by openshift-operations
export QUEUE_PORT="9092"

# Disable prometheus
export METRICS_PORT=0

# RVM ruby version & gemset
# Optional, if you're using RVM
export RVM_RUBY_VERSION_TP_INV="2.5.3"
export RVM_GEMSET_NAME_TP_INV="tp-inv"

# Uncomment if you want to disable tenancy
# export BYPASS_TENANCY=1

# Sources API can be accessed by anyone (default access: org-admin)
export BYPASS_RBAC=true

# Topological Inventory Persister
export PERSISTER_DIR="$root_dir/topological_inventory-persister"

# Topological Inventory Sources Sync
export TOPOLOGICAL_INVENTORY_SOURCES_SYNC_DIR="$root_dir/topological_inventory-sync"

# Ingress API service (Persister <-> Collectors)
export INGRESS_API_DIR="$root_dir/topological_inventory-ingress_api"
export INGRESS_API="http://localhost:9292"
export TOPOLOGICAL_INVENTORY_INGRESS_API_SERVICE_HOST="http://localhost"
export TOPOLOGICAL_INVENTORY_INGRESS_API_SERVICE_PORT="9292"

# Topological API service
export TOPOLOGICAL_API_DIR="$root_dir/topological_inventory-api"
export TOPOLOGICAL_INVENTORY_API_SERVICE_HOST="http://localhost" # used by openshift operations
export TOPOLOGICAL_INVENTORY_API_SERVICE_PORT=3001
export TOPOLOGICAL_INVENTORY_URL="http://localhost:3001"
# - Used by api scripts
export TOPOLOGICAL_INVENTORY_API_BASE_PATH="api/topological-inventory/v1.0"

# Sources API service
export SOURCES_API_DIR="$root_dir/sources-api"
export SOURCES_SCHEME="http"
export SOURCES_HOST="localhost"
export SOURCES_PORT="3002"
# - Used by api scripts
export SOURCES_API_BASE_PATH="api/sources/v1.0"

# Mock Source
export MOCK_SOURCE_DIR="$root_dir/topological_inventory-mock_source"
export MOCK_SOURCE_UID="5eebe172-7baa-4280-823f-19e597d091e9"  # random value for dev
export MOCK_SOURCE_CONFIG="simple"
export MOCK_SOURCE_DATA="small"

# Openshift
export OPENSHIFT_DIR="$root_dir/topological_inventory-openshift"
export OPENSHIFT_SOURCE_UID="31b5338b-685d-4056-ba39-d00b4d7f19cc"  # random value for dev
export OPENSHIFT_SCHEME="https"
export OPENSHIFT_HOST=""
export OPENSHIFT_PORT=""
export OPENSHIFT_USER=""
export OPENSHIFT_PASSWORD=""
export OPENSHIFT_API_PATH="/api" # kubernetes API

# Amazon
export AMAZON_DIR="$root_dir/topological_inventory-amazon"
export AMAZON_SOURCE_UID="592ba27a-2b89-11e9-b210-d663bd873d93" # random value for dev
export AMAZON_ACCESS_KEY_ID=""
export AMAZON_SECRET_ACCESS_KEY=""

# Ansible Tower
export ANSIBLE_TOWER_DIR="$root_dir/topological_inventory-ansible_tower"
export ANSIBLE_TOWER_SOURCE_UID="23d05717-ad56-4eec-8c34-cc0322e2c411"  # random value for dev
export ANSIBLE_TOWER_SCHEME="https"
export ANSIBLE_TOWER_HOST=""
export ANSIBLE_TOWER_USER=""
export ANSIBLE_TOWER_PASSWORD=""

# Azure
export AZURE_DIR="$root_dir/topological_inventory-azure"
export AZURE_SOURCE_UID="4af9131d-d200-4516-950e-83f9926462a9"
export AZURE_CLIENT_ID=""
export AZURE_CLIENT_SECRET=""
export AZURE_SUBSCRIPTION_ID=""

# UI
export INSIGHTS_PROXY_DIR="$root_dir/insights-proxy"
export SPANDX_CONFIG_PATH="$root_dir/scripts/insights-proxy/insights-proxy.config.js"

export INSIGHTS_CHROME_DIR="$root_dir/insights-chrome"
export SOURCES_UI_DIR="$root_dir/sources-ui"

# Orchestrator
export ORCHESTRATOR_DIR="$root_dir/topological_inventory-orchestrator"
