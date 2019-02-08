#!/bin/bash
#
# Script for cloning topology inventory repos
# Usage: clone-tp-inv.sh [clone|clone-manageiq]
#
# NOTE: Edit your variables below!
source config.sh

cd $root_dir

operation=$1

if [[ "$operation" == "clone" || "$operation" == "clone-manageiq" ]]; then

	for name in ${repositories[@]} 
	do
		echo "Cloning into: $name -------------------------------------------------------"

		# 1) Clone your forks, adding upstream
		if [ "$operation" == "clone" ]; then
			git clone git@github.com:$github_name/$name $name
			cd $name
			git remote add upstream git@github.com:ManageIQ/$name
			cd ..
		# 2) Clone from ManageIQ namespace	
		elif [ "$operation" == "clone-manageiq" ]; then
			git clone git@github.com:ManageIQ/$name
		fi	
	done

else
	# Print help
	echo "Usage: clone-tp-inv.sh [clone|clone-manageiq]"
fi

