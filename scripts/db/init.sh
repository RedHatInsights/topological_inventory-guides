#!/bin/bash --login

source config.sh
source init-common.sh

cwd=$(pwd)

cd ${TOPOLOGICAL_API_DIR}

bundle exec rake db:create

cd ${SOURCES_API_DIR}
bundle exec rake db:create

cd ${cwd}
reset.sh
