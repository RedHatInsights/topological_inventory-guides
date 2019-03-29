#!/bin/bash --login
# Usage ./restart.sh <service name>

source config.sh

service=$1	  

if [ -z $service]; then
	echo "Usage: ./restart.sh <service name>"
else
	echo "Restarting $service..."
	tmux kill-window -t TpInv:$service &> /dev/null
	tmux new-window -t TpInv -n $service "
	services/$service.sh"
fi

