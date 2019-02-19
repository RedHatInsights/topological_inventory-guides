BASE_DIR=~/Projects
mkdir -p $BASE_DIR

cd $BASE_DIR
if [ ! -d insights-proxy ]; then
  git clone git@github.com:RedHatInsights/insights-proxy.git
  cd insights-proxy
  npm install
  sudo bash scripts/patch-etc-hosts.sh
  bash scripts/update.sh
fi

cd $BASE_DIR
if [ ! -d insights-chrome ]; then
  git clone git@github.com:RedHatInsights/insights-chrome.git
  cd insights-chrome
  npm install
  npm run build
fi

cd $BASE_DIR
if [ ! -d  topological_inventory-ui ]; then
  git clone git@github.com:ManageIQ/topological_inventory-ui.git
  cd topological_inventory-ui
  if [ ! -z "$GH_USER" ] ; then
    git remote rename origin upstream
    git remote add origin git@github.com:$GH_USER/topological_inventory-ui.git
  fi
  npm install
fi


