# Topological Inventory (tp-inv) guides

# Installation 

## Prerequisities

**RVM**

If you're not using rvm, rewrite scripts according your needs

**Config file**

- Create your Topological Inventory root directory 
- Copy content of scripts directory into it 
- Edit [config.sh](scripts/config.sh) and set variables including your root directory 

**Download and setup topological-inventory**

Setup expects you have fork of all repositories listed in [config.sh](scripts/config.sh) file.

If yes, run: [setup-tp-inv.sh](scripts/setup-tp-inv.sh)

If you don't want to fork, you can clone ManageIQ repositories directly, see [clone-tp-inv.sh](scripts/clone-tp-inv.sh) for details. 

## Persister, kafka and Ingress API server

Persister, Kafka and Ingress API are backend core of tp-inv.

### How to run them:

```
# Open 1st terminal:
kafka.sh start
# Now wait for a while for initialization

# Open 2nd terminal
cd <topological inventory root>/topological_inventory-ingress_api
bundle exec rackup

# Open 3rd terminal
cd <topological inventory root>/topological_inventory-persister
bin/topological_inventory-persister

```

And your local tp-inv core parts should be ready!

### How to stop them:
```
# On 2nd and 3rd terminal:
terminate process (CTRL+C on Fedora)

# On 1st terminal
kafka.sh stop
```

## Collectors

Collectors are responsible for collecting data from providers. Actually available:
- [Openshift collector](https://github.com/ManageIQ/topological_inventory-collector-openshift)
- [Amazon collector](https://github.com/ManageIQ/topological_inventory-collector-amazon)
- [Mock collector](https://github.com/ManageIQ/topological_inventory-collector-mock)

### How to run collector

You can find instructions in Readme of each collector.  
Source guids needed to run them are initialized by [reset-db-tp-inv.sh](scripts/reset-db-tp-inv.sh) 

## UI

*TODO*

# Daily maintenance

All daily maintenance scripts are helpers for mass operations over repositories.
They uses [config.sh](scripts/config.sh) to get list of them. 

## Reset your database
It resets your database and seeds basic data including Sources 

[reset-db-tp-inv.sh](scripts/reset-db-tp-inv.sh)

## Mass bundle

[bundle-tp-inv.sh](scripts/bundle-tp-inv.sh) [install|update]

## Mass checkout master & pull

Expects you have forks as origin and ManageIQ repos as upstream

[pull-tp-inv.sh](scripts/pull-tp-inv.sh)
