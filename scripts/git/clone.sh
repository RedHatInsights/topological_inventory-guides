#!/bin/bash
#
# Script for cloning topology inventory and sources repos
#
# * creates root directory defined in config.sh
# * if repo directory exists, skips cloning repo 
# * otherwise checks if your fork exists (github name defined in config.sh)
# * if exists, clones fork and adds ManageIQ as upstream
# * if not exists, clones ManageIQ as origin
#
# Usage: clone.sh
#
# NOTE: Edit your variables below!
source ../config.sh

mkdir -p ${root_dir}
cd ${root_dir}

for name in ${repositories[@]} 
do
    if [[ ${name} == "insights-proxy" || ${name} == "insights-chrome" ]]; then
        upstream_org="RedHatInsights"
    else
        upstream_org="ManageIQ"
    fi

	echo "----------------------------------------------------------------------"
	#
	# 1) Check if repo already cloned
	#
	if [[ -d "$root_dir/$name" ]]; then
		echo "* [SKIPPED] Cloning into: $name"
		echo "* Repository directory already found"
	else
		echo "* Cloning into: $name"
		#
		# 1) Check if repo is forked
		#
		forked=`curl --silent -H "Authorization: token ${MY_GITHUB_TOKEN}" -X GET "https://api.github.com/repos/$MY_GITHUB_NAME/$name" | grep "\"name\": \"$name\"" | wc -l`
		if [[ "$forked" -gt "0" ]]; then
			echo "[FOUND] Fork git@github.com:$MY_GITHUB_NAME/$name"
		else
			echo "[NOT FOUND] Fork git@github.com:$MY_GITHUB_NAME/$name not found. Using $upstream_org repo as origin."
		fi	
		echo " "	
		#
		# 2 ) Clone
		#	
		# 2a) Clone your forks, adding upstream
		if [[ "$forked" -gt "0" ]]; then
			git clone git@github.com:$MY_GITHUB_NAME/$name $name
			cd $name
			git remote add upstream git@github.com:$upstream_org/$name
			cd ..
		# 2b) Clone from ManageIQ/RedHatInsights namespace
		elif [[ "$forked" -eq "0" ]]; then
			git clone git@github.com:$upstream_org/$name
		fi	
	fi
	echo " "
done
