#!/bin/bash

# Script for git updating git branch master topology inventory plugins
# Switches to master branches
#
# NOTE: Edit your variables below!
source config.sh

cd $root_dir

for name in ${repositories[@]} 
do
	echo "$name -------------------------------------------------------"
	cd $name
	git fetch --all --prune
	git checkout master
	
	has_upstream=`git branch -a | grep upstream | wc  -l`

	if [[ "$has_upstream" -gt "0" ]]; then
		git pull upstream master
	else
		git pull origin master
	fi
	cd ..
done

