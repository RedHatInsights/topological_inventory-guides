BOLD=$(tput bold)
NORMAL=$(tput sgr0)

export BASE_DIR=~/Projects

# binding a dir into a container does not work when enforcing
echo ${BOLD}Checking if Enforcing${NORMAL}
getenforce | grep Enforcing && sudo setenforce 0

# start docker if not running
echo ${BOLD}Checking Docker${NORMAL}
service docker status | grep inactive && sudo service docker start

echo ${BOLD}Starting tmux${NORMAL}
tmux new-session -d -s Insights

tmux new-window -t Insights -n proxy '
	cd $BASE_DIR/insights-chrome/build &&
		LOCAL_CHROME=true bash $BASE_DIR/insights-proxy/scripts/run.sh'

tmux new-window -t Insights -n chrome '
	cd $BASE_DIR/insights-chrome &&
		npm run start'

tmux new-window -t Insights -n app '
	cd $BASE_DIR/topology-inventory-ui &&
		npm run start'

sleep 10
google-chrome https://prod.foo.redhat.com:1337/insights/topological-inventory

tmux attach-session -t Insights
