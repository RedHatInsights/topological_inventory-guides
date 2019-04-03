#!/bin/bash --login
# Usage ./stop.sh

tmux kill-session -t TpInv

container_id=`docker container ls | grep "insights-proxy" | awk '{print $1}'`
if [ ! -z $container_id ]; then
	echo "Stopping docker container \"insights-proxy\""
	docker stop $container_id
fi	
