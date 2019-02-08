# Your Github account name used for cloning
# - if you forked all the repos, see clone.sh for options
github_name="slemrmartin" # https://github.com/<github_name>/<repository name>

# Root directory for cloned repositories
root_dir="/home/mslemr/Projects/topological-inventory-test"

# Get latest release URL at https://kafka.apache.org/quickstart
kafka_url="http://apache.miloslavbrada.cz/kafka/2.1.0/kafka_2.11-2.1.0.tgz"
# Directory below is created automatically by script setup-tp-inv.sh
kafka_dir="$root_dir/kafka"

# Scripts are using RVM
rvm_ruby_version_tp_inv="2.4"
rvm_gemset_name_tp_inv="tp-inv"

# Array of repositories maintained by other scripts
repositories=("topological_inventory-api"
	      "topological_inventory-core"
              "topological_inventory-ingress_api"
              "topological_inventory-ingress_api-client-ruby"
	      "topological_inventory-persister"		   
              "topological_inventory-collector-amazon"
              "topological_inventory-collector-mock"
              "topological_inventory-collector-openshift"
              "inventory_refresh"
	     )

