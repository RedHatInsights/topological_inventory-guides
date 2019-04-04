# Your Github account name used for cloning
export MY_GITHUB_NAME="" # https://github.com/<MY_GITHUB_NAME>/<repository name>
# Get Github API token there
# Needed for Github API requests
# https://help.github.com/en/articles/creating-a-personal-access-token-for-the-command-line
export MY_GITHUB_TOKEN=""

# Root directory for cloned repositories
# created by install script install.sh
root_dir="/home/mslemr/Projects/topological-inventory"

if [ "$(uname)" == "Darwin" ]; then
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

# RVM ruby version & gemset 
export RVM_RUBY_VERSION_TP_INV="2.5.3"
export RVM_GEMSET_NAME_TP_INV="tp-inv"

# Topological Inventory Persister
export PERSISTER_DIR="$root_dir/topological_inventory-persister"

# Ingress API service (Persister <-> Collectors)
export INGRESS_API_DIR="$root_dir/topological_inventory-ingress_api"
export INGRESS_API="http://localhost:9292"

# Topological API service
export TOPOLOGICAL_API_DIR="$root_dir/topological_inventory-api"
export TOPOLOGICAL_INVENTORY_API_SERVICE_HOST="http://localhost" # used by openshift operations
export TOPOLOGICAL_INVENTORY_API_SERVICE_PORT=3000
# Uncomment if you want to disable tenancy
#export BYPASS_TENANCY=1

# Sources API service
export SOURCES_API_DIR="$root_dir/sources-api"
export SOURCES_API_SERVICE_HOST="http://localhost" # not used now
export SOURCES_API_SERVICE_PORT=3002

# Mock Source
export MOCK_SOURCE_DIR="$root_dir/topological_inventory-mock_source"
export MOCK_SOURCE_UID="31b5338b-685d-4056-ba39-d00b4d7f19cc"
export MOCK_SOURCE_CONFIG="simple"
export MOCK_SOURCE_AMOUNTS="small"

# Openshift
export OPENSHIFT_DIR="$root_dir/topological_inventory-openshift"
export OPENSHIFT_SOURCE_UID="31b5338b-685d-4056-ba39-d00b4d7f19cc"
export OPENSHIFT_SCHEME="https"
export OPENSHIFT_HOST=""
export OPENSHIFT_PORT=""
export OPENSHIFT_USER=""
export OPENSHIFT_PASSWORD=""
export OPENSHIFT_API_PATH="/api" # kubernetes API

# Amazon
export AMAZON_DIR="$root_dir/topological_inventory-amazon"
export AMAZON_SOURCE_UID="592ba27a-2b89-11e9-b210-d663bd873d93"

# Ansible Tower
export ANSIBLE_TOWER_DIR="$root_dir/topological_inventory-ansible_tower"
export ANSIBLE_TOWER_SOURCE_UID="23d05717-ad56-4eec-8c34-cc0322e2c411"
export ANSIBLE_TOWER_SCHEME="https"
export ANSIBLE_TOWER_HOST=""
export ANSIBLE_TOWER_USER=""
export ANSIBLE_TOWER_PASSWORD=""

# UI
export INSIGHTS_PROXY_DIR="$root_dir/insights-proxy"
export INSIGHTS_CHROME_DIR="$root_dir/insights-chrome"
export TOPOLOGICAL_INVENTORY_UI_DIR="$root_dir/topological_inventory-ui"

# Array of repositories maintained by other scripts
repositories=("topological_inventory-api"
              "topological_inventory-api-client-ruby"
	      "topological_inventory-core"
              "topological_inventory-ingress_api"
              "topological_inventory-ingress_api-client-ruby"
	      "topological_inventory-persister"		   
              "topological_inventory-amazon"
              "topological_inventory-mock_source"
              "topological_inventory-openshift"
	      "sources-api"
              "sources-api-client-ruby"
              "inventory_refresh"
	     )

