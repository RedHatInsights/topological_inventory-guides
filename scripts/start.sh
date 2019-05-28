#!/bin/bash --login
# Usage ./start.sh [service_name] 

source config.sh
source ./init-common.sh

requested_svc=$1

if [[ -z ${requested_svc} ]]; then

    if [[ $MAC_OS == false ]]; then
      # binding a dir into a container does not work when enforcing
      echo "Checking if Enforcing"
      getenforce | grep Enforcing && sudo setenforce 0
    fi

    # start docker if not running
    echo "Checking Docker"
    if [[ $MAC_OS == true ]]; then
      if (! docker stats --no-stream ); then
        # On Mac OS this would be the terminal command to launch Docker
        open /Applications/Docker.app
        #Wait until Docker daemon is running and has completed initialisation
      while (! docker stats --no-stream ); do
        # Docker takes a few seconds to initialize
        echo "Waiting 20s for Docker to launch..."
        sleep 20
      done
      fi
    else
      service docker status | grep inactive && sudo service docker start
    fi

	tmux new-session -d -s TpInv

	services=("kafka"
              "persister"
        	  "ingress-api"
	          "topological-api"
		      "sources-api"
		      "sources-sync"
	          "insights-proxy"
	          "insights-chrome"
	          "ui"	        
	          )

	for service in ${services[@]}
	do
		echo "(Re)starting $service"
		stop_svc_in_tmux ${service}
 
	    start_svc_in_tmux ${service}
	done

	# google-chrome https://ci.foo.redhat.com:1337/insights/settings/sources

	tmux attach-session -t TpInv
else
                echo "(Re)starting $requested_svc"
                stop_svc_in_tmux ${requested_svc}
                start_svc_in_tmux ${requested_svc}
fi
