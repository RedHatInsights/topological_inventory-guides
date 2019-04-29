#!/bin/bash --login
# Usage ./stop.sh [service_name]

source config.sh
source ./init-common.sh

requested_svc=$1

if [[ -z ${requested_svc} ]]; then
    tmux kill-session -t TpInv

    container_id=`docker container ls | grep "insights-proxy" | awk '{print $1}'`
    if [[ ! -z ${container_id} ]]; then
        echo "Stopping docker container \"insights-proxy\""
        docker stop ${container_id}
    fi
else
    stop_svc_in_tmux ${requested_svc}
fi
