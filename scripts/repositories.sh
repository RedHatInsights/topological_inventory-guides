#!/usr/bin/env bash
# List of repositories/services/directories/TMUX windows for all mass operations
# This file is included in config[.dev].sh, redefine variables in your config.sh file if you need :)

# Array of repositories maintained by other scripts
repositories=("inventory_refresh"
              "insights-proxy"
              "sources-api"
              "sources-api-client-ruby"
              "sources-monitor"
              "sources-satellite"
              "sources-superkey-worker"
              "sources-ui"
              "topological_inventory-amazon"
              "topological_inventory-ansible_tower"
              "topological_inventory-api"
              "topological_inventory-api-client-ruby"
              "topological_inventory-azure"
              "topological_inventory-core"
              "topological_inventory-google"
              "topological_inventory-host_inventory_sync"
              "topological_inventory-ingress_api"
              "topological_inventory-ingress_api-client-ruby"
              "topological_inventory-mock_source"
              "topological_inventory-openshift"
              "topological_inventory-orchestrator"
              "topological_inventory-persister"
              "topological_inventory-scheduler"
              "topological_inventory-sync"
             )

# When script "start.sh" is run without parameters, these services are started.
# Overwrite in your config.sh, if you want different list
: ${start_by_default:="kafka"
                      "persister"
                      "ingress-api"
                      "topological-api"
                      "sources-api"
                      "sources-sync"
                      "insights-proxy"
                      }

