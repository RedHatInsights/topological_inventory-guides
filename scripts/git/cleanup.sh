#!/bin/bash
# Script for git cleanup - delete merged branches
# Switches to master branches
#
# Usage: cleanup.sh [--force]

source config.sh

case $1 in
    -h|--help) echo "Usage: cleanup.sh [--remote-cleanup]";;
    -f|--remote-cleanup) remote_cleanup=1;;
esac

cd ${root_dir}

for name in ${repositories[@]}
do
	echo "${name} -------------------------------------------------------"
	cd ${name}

    # This has to be run from master
    git checkout master

    # Update our list of remotes
    git fetch
    git remote prune origin

    # Remove local fully merged branches
    git branch --merged master | grep -v 'master$' | xargs git branch -d

    # Show remote fully merged branches
    echo "The following remote branches are fully merged and will be removed:"
    git branch -r --merged master | sed 's/ *origin\///' | grep -v 'master$'

    has_upstream=`git branch -a | grep upstream | wc  -l`

    if [[ ${remote_cleanup} -eq 1 && "$has_upstream" -gt "0" ]]
    then
       # Remove remote fully merged branches
       git branch -r --merged master | sed 's/ *origin\///' \
                 | grep -v 'master$' | xargs -I% git push origin :%
       echo "Done!"
    fi
    echo "Obsolete branches are removed"

	cd ..
done
