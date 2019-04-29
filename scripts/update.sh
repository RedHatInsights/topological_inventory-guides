#!/bin/bash --login
#
# Script for mass bundle topology inventory plugins
# Usage: update.sh
#
# NOTE: Edit your variables below!
source config.sh
source init-common.sh

cd ${root_dir}

operation=$1

for name in ${repositories[@]} 
do
	echo "$name -------------------------------------------------------"
	
	cd ${name}
		
	if [[ -f ./Gemfile ]]; then
		bundle update
	elif [[ ${name} == "insights-proxy" ]]; then
		npm install
		./scripts/update.sh
	elif [[ ${name} == "insights-chrome" ]]; then
		npm install
		npm run build
	elif [[ ${name} == "topological_inventory-ui" ]]; then
		npm install
	else						
		echo "[SKIPPED] This repository doesn't have Gemfile"
	fi

	cd ..
done

echo "Migrating Topological inventory: core"
cd topological_inventory-core
bundle exec rake db:migrate
cd ..

echo "Migrating Sources API"
cd sources-api
bundle exec rake db:migrate
cd ..


