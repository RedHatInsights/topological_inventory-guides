# Deployment by Clowder and Bonfire
 
This doc describes how to deploy & cleanup Sources & Topological Inventory apps
either to your local minikube/CRC or remote cluster with ephemeral environments.

## Prerequisites
- Clone & install Bonfire (to the root_dir specified in your config.sh)
  - https://internal.cloud.redhat.com/docs/devprod/ephemeral/01-onboarding/

- Ruby gems used by i.e. sources api must be available    
- Copy `templates/sources.default.yaml` to `templates/sources.local.yaml`
- Copy `templates/topological.default.yaml` to `templates/topological.local.yaml`

- Podman (if you want to upload your quay images)  

If you want to use your minikube/openshift, follow the instructions: 
- https://github.com/RedHatInsights/clowder#getting-clowder
- oc apply -f templates/clowd-environment-*.yaml (change targetNamespace/namespace values in case of CRC) 

## Login 

Login to the minikube/openshift by `oc login`

## Deployment

### Configuration

Open your `sources.local.yaml`, there are several sections:
- configuration: 
  - update your root paths
  - app_interface_env: \[insights-production|insights-stage\]
    - applied for repos with `sources: app-interface`
    - By default, bonfire will use a “reference environment” of insights-production. This means that it will look at each component’s production deployment target to determine the template_ref and IMAGE_TAG to use. If you want to use stage as the reference environment, pass the option `insights-stage`
- repos_to_deploy:
  - comment items you don't want to deploy/cleanup
  - source: 
    - local: apps are deployed using your quay image/image tag, clowdapp.yaml in your local repo and parameters in the config
    - app-interface: apps are deployed using configuration in app-interface (by default with parameters from production env)
- common_parameters:
  - these parameters are used for all repos with `source: local` deployment
- apps:
  - these parameters are used with `source: local` deployment
  - IMAGE_TAGs are pointing to images in your `quay_root`
    - see the chapter "Creating Quay.io Images" for more details
    
###  Deploying

There is a `deployer.rb` which is parsing your `templates/sources.local.yaml` and does the following:
- deploying to your openshift/minikube
- get/reserve an ephemeral namespace and deploy to the ephemeral cluster
- cleanup

Usage: 
```
./deployer.rb --config=templates/sources.local.yaml 
              --target=[ephemeral|local]
              [--cleanup]
              [--dry-run]
              
options:
--config: path to your config
--target: switch between ephemeral cluster/local minikube(crc)
--cleanup (optional): deletes apps specified in your sources.local.yaml in "repos_to_deploy" section
--dry-run (optional): reserves env, parses config, but doesn't deploy
```

The deployer parses your `sources.local.yaml` and generates `templates/bonfire-sources.local.yaml` which is used for the deployment
(similarly it generates `topological.local.yaml` -> `bonfire-topological.local.yaml`)

## Creating Quay.io Images

If you want to use images from your local source code, follow these steps:
- create quay repository (in your `quay_root`) with the same name as an app name (it means GH repository name with '-' instead of '_')
- remove `.bundle` directory from your local repository
- run `export QUAY_ROOT="quay.io/<user>"`
    - i.e. `export QUAY_ROOT="quay.io/mslemr"`
- run `cd <your local repository>; ../scripts/clowder/quay.sh <quay repository`
    - i.e `cd ~/Projects/RedHatInsights/sources-api; ../scripts/clowder/quay.sh sources-api`
    - it returns the IMAGE_TAG value  
