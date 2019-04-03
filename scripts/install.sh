#!/bin/bash --login
#
source config.sh
source init-common.sh

cwd=$(pwd)

#
# 1) create root directory
#
echo "-------------------------------------------------------"
echo "Creating root directory..."
mkdir -p $root_dir
cd $root_dir

#
# 2) download kafka
#
echo "-------------------------------------------------------"
echo "Downloading Kafka..."
wget -O kafka.tgz $KAFKA_INSTALL_URL
tar -xzf kafka.tgz
mv ./kafka_* ./kafka

cd $cwd
#
# 3) make all scripts executable
#
echo "-------------------------------------------------------"
echo "Making these scripts executable, creating symlink..."
chmod 744 ./*.sh
chmod 744 ./services/*.sh

ln -s $cwd $root_dir/scripts

#
# 4) clone forked/manageiq repos (checks for forks automatically)
#    skips existing clones
#
echo "-------------------------------------------------------"
echo "Cloning repositories..."
cd $cwd
./clone.sh

#
# 5) bundle gems
#
echo "-------------------------------------------------------"
echo "Bundle all repos"
gem install bundler
./bundle.sh update

# 
# 6) create database.yml based on topological_inventory-api's database.dev.yml
# 
echo "-------------------------------------------------------"
echo "Copying database.yml from topological_inventory-api/config/database.dev.yml..."
cd $root_dir
cd ./topological_inventory-api
echo "topological_inventory-api/config/database.yml"
cp config/database.dev.yml config/database.yml
echo "topological_inventory-core/config.database.yml"
cp config/database.dev.yml ../topological_inventory-core/config/database.yml
echo "topological_inventory-persister/config.database.yml"
cp config/database.dev.yml ../topological_inventory-persister/config/database.yml
echo "sources-api/config/database.yml"
cp config/database.dev.yml ../sources-api/config/database.yml

#
# 7) creates Gemfile.dev.rb
#
echo "-------------------------------------------------------"
echo "Creating Gemfile.dev.rb..."
for name in ${repositories[@]}
do
	cd "$root_dir/$name"
	if [ ! -d "$root_dir/$name/bundler.d" ]; then
		mkdir bundler.d
		touch ./bundler.d/.gitkeep
	fi
	cd bundler.d
	touch Gemfile.dev.rb
done

#
# 8) Configure UI
#
echo "-------------------------------------------------------"
cd "$root_dir/insights-proxy"
npm install
sudo bash scripts/patch-etc-hosts.sh
bash scripts/update.sh

cd "$root_dir/insights-chrome"
npm install
npm run build

cd "$root_dir/topological_inventory-ui"
npm install

echo "-------------------------------------------------------"
echo "Successfully installed!"
echo ""
echo "--- And what next? ---"
echo "Check all database.yml files (see above) and change db name if needed"
echo "Run ./init-db.sh to create and initialize database"
echo "Run ./reset-db.sh to reset and initialize database if exists"
echo "Run ./start.sh to run persister and api services in TMUX"
echo "Run ./start.sh <svc> to run service (see list in services directory)"
echo ""

LANG=C DOW=$(date +"%a")
echo "Happy $DOW! :)"

