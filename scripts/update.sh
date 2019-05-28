#!/bin/bash --login
#
# Script for mass bundle topology inventory plugins
# Usage: update.sh
#
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

db/migrate.sh
