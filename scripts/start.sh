#!/bin/bash --login
# Usage ./start.sh [service_name] 

source config.sh

requested_svc=$1

if [ -z $requested_svc ]; then
	tmux new-session -d -s TpInv

	services=("kafka"
		  "ingress-api"
        	  "persister"
	          "topological-api")

	for service in ${services[@]}
	do
		echo "(Re)starting $service"
		tmux kill-window -t TpInv:$service &> /dev/null
 
		if [ $service == "kafka" ]; then
			tmux new-window -t TpInv -n kafka "services/kafka.sh start"
			echo "Waiting for Kafka initialization 20 sec..."
			sleep 20
			echo "Done"
		else
        		tmux new-window -t TpInv -n $service "services/$service.sh"
		fi
	done
	
	tmux attach-session -t TpInv
else
                echo "(Re)starting $requested_svc"
                tmux kill-window -t TpInv:$requested_svc &> /dev/null
                tmux new-window -t TpInv -n $requested_svc "services/$requested_svc.sh"	
fi


