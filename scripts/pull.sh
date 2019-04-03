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
	git pull upstream master
	git push origin master
	cd ..
done

