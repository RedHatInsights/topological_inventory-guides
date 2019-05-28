#!/bin/bash

# Script for git updating git branch master topology inventory plugins
# Switches to master branches
#
# NOTE: Edit your variables below!
source ../config.sh

cd $root_dir

for name in ${repositories[@]} 
do
	cd ${name}
		current_branches=$(git branch)
		echo ""
		echo "${name}"
		echo "${current_branches}"
	cd ..
done

