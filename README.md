# Topological Inventory (tp-inv) guides

These guides describes how to install and run Topological Inventory 

## Prerequisities

**RVM (optional)**

Ruby version manager
https://rvm.io/rvm/install  
If you're not using rvm, just remove content of [init-common.sh](scripts/init-common.sh) in case of problems.
If you're using rvm, create gemset for this project.

**TMUX**

Terminal multiplexer is required for automatized starting/restarting/stopping services in one session.
https://linuxize.com/post/getting-started-with-tmux/

**GitHub Token**

GitHub token is needed for API requests by install script. It detects which repositories you have forked and which not
https://help.github.com/en/articles/creating-a-personal-access-token-for-the-command-line

**Kafka**

Kafka is messaging server used for sending data across services.
Just get the current link to latest stable archive there: https://kafka.apache.org/quickstart

**Docker**

Docker is needed for running UI service.
Installations steps here: https://docs.docker.com/install/linux/docker-ce/fedora/

Mac users: https://docs.docker.com/docker-for-mac/install/

**NPM**

NPM is needed for running UI service (and insights proxy)
https://www.npmjs.com/get-npm

**Config file**

Config file contains all information for installation and running services.  
Default values are filled in [config.default.sh](scripts/config.default.sh).
- Create *config.sh* with this content:
  - ```
    #!/bin/bash
    source "config.default.sh"
    ```
- Redefine values in `config.sh`:    
  - Your github name (_MY_GITHUB_NAME_)
  - Your github token (_MY_GITHUB_TOKEN_)
  - Your root directory for repositories (_root_dir_)
  - URL to kafka archive (see chapter above) (_KAFKA_INSTALL_URL_)
  - RVM ruby version you want to use (if using rvm) (_RVM_RUBY_VERSION_TP_INV_)
  - RVM gemset name you want to use (if using rvm) (_RVM_GEMSET_NAME_TP_INV_)

## Installation

- Switch to `scripts` directory 
- Run [install.sh](scripts/install.sh)
- Check your `config/database.yml` files if you want custom db name for **topological_inventory** service in repositories (all must point to the same db):
  - topological_inventory-api
  - topological_inventory-core
  - topological_inventory-persister
  - topological_inventory-sync
- Check your `config/database.yml` if you want custom db name for **sources** service
  - sources-api
- Run [init-db.sh](scripts/init-db.sh)
  - If your db exists, you can run only [reset-db.sh](scripts/reset-db.sh) (existing data will be lost!)
  - Or [migrate-dbs.sh](scripts/migrate-dbs.sh) for migrations only

## Starting services

Starting Persister and API services is pretty easy:

- Switch to `scripts` directory (symlink was added to your repository `root_dir` by installation script)
- Run `start.sh` (list of services can be redefined by defining variable `$start_by_default` in `config.sh` - see [repositories.sh](scripts/repositories.sh))

Note: by default, topological inventory API is running on `localhost:3001`, sources API on `localhost:3002`. You can change it in `config.sh`

Starting collectors and operation workers:
- Fill service env variables (like credentials) in `scripts/config.sh` 
- Run `start.sh <service_name>`

You can find list by running [list-services.sh](scripts/list-services.sh).

## Restarting services
- Run `restart.sh <service_name>` 

## Stop all services:
- Run `stop.sh`

## Collectors

Collectors are responsible for collecting data from providers. Actually available:
- [Openshift collector](https://github.com/ManageIQ/topological_inventory-openshift)
- [Amazon collector](https://github.com/ManageIQ/topological_inventory-amazon)
- [Ansible Tower collector](https://github.com/ManageIQ/topological_inventory-ansible_tower)
- [Mock collector](https://github.com/ManageIQ/topological_inventory-mock_source)


## UI

When all services are started, access UI in browser on this URL:
https://ci.foo.redhat.com:1337/insights/settings/sources

## Maintenance / Daily operations

Following scripts helps with commonly used mass operations.

### GIT

- [pull.sh](scripts/git/pull.sh): Checkouts all unchanged repos to master and pulls changes
- [rebase.sh](scripts/git/rebase.sh): For all unchanged repos does the same as pull.sh and then rebases your current branch.
- [list-branches.sh](scripts/git/list-branches.sh): Prints current branches in all repos
- [list-changes.sh](scripts/git/list-changes.sh): Prints changes in all repos 
- [clone.sh](scripts/git/clone.sh): Cloning of repositories specified in config.sh. Part of install script.
- [cleanup.sh](scripts/git/cleanup.sh): Deletes branches merged to master. Without arg: local branches, with `--remote-cleanup` also deletes merged remote branches.

### Database
- [init.sh](scripts/db/init.sh): Creates databases, runs migrations and init-data.sh
- [init-data.sh](scripts/db/init-data.sh): Seeds, creates Tenants, SourceTypes and Sources
- [reset-dbs.sh](scripts/db/reset.sh): Resets databases (**deletes existing data!**) and seeds + creates Sources
- [migrate.sh](scripts/db/migrate.sh): Migrates both databases

### Other

- [bundle.sh](scripts/bundle.sh): Bundles all repositories which contains Gemfile
- [update.sh](scripts/update.sh): Bundles repositories with Gemfile, runs npm build on UI, insights-chrome and insights-proxy repositories and runs migrations on `topological_inventory-core` and `sources-api`
