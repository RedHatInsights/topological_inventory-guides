#!/usr/bin/env bash

source "config.sh"

plain_rh_identity="{\"identity\":{\"account_number\":\"${MY_GITHUB_NAME}\"}, \"internal\": {\"org_id\": \"54321\"}}"

# base64 can split output to more lines, forbid it with one of following
# depends on base64 version:
export X_RH_IDENTITY=$(echo ${plain_rh_identity} | base64 --wrap=0)
# export X_RH_IDENTITY=$(echo ${plain_rh_identity} | base64)
# export X_RH_IDENTITY=$(echo ${plain_rh_identity} | base64 --break=0)

# Usage: topological_api_get <path>
# Example: topological_api_get "source_types?filter[name]=mock"
function topological_api_get {
    if [[ -z $2 ]]; then
        api_path=${TOPOLOGICAL_INVENTORY_API_BASE_PATH}
    else
        api_path=$2
    fi
    curl -H "x-rh-identity: ${X_RH_IDENTITY}" \
         --silent \
        "${TOPOLOGICAL_INVENTORY_API_SERVICE_HOST}:${TOPOLOGICAL_INVENTORY_API_SERVICE_PORT}/${api_path}/$1"
}

# Usage: api_post <path> <data>
# Example: api_post "sources" "{\"name\":\"Mock Source 1\",\"source_type_id\":\"4\"}"
function topological_api_post {
    curl --request POST \
         --header "Content-Type: application/json" \
         --header "x-rh-identity: ${X_RH_IDENTITY}" \
         --data "$2" \
         --silent \
         "${TOPOLOGICAL_INVENTORY_API_SERVICE_HOST}:${TOPOLOGICAL_INVENTORY_API_SERVICE_PORT}/${TOPOLOGICAL_INVENTORY_API_BASE_PATH}/$1"
}

# Usage: api_post <path> <data>
# Example: api_post "sources" "{\"name\":\"Mock Source 1\",\"source_type_id\":\"4\"}"
function topological_api_patch {
    curl --request PATCH \
         --header "Content-Type: application/json" \
         --header "x-rh-identity: ${X_RH_IDENTITY}" \
         --data "$2" \
         --silent \
         "${TOPOLOGICAL_INVENTORY_API_SERVICE_HOST}:${TOPOLOGICAL_INVENTORY_API_SERVICE_PORT}/${TOPOLOGICAL_INVENTORY_API_BASE_PATH}/$1"
}

# Usage: api_delete <path>
# Example: api_delete "sources/1"
function topological_api_delete {
    curl --request DELETE \
         --header "x-rh-identity: ${X_RH_IDENTITY}" \
         --silent \
         "${TOPOLOGICAL_INVENTORY_API_SERVICE_HOST}:${TOPOLOGICAL_INVENTORY_API_SERVICE_PORT}/${TOPOLOGICAL_INVENTORY_API_BASE_PATH}/$1"
}

# Usage: api_get <path>
# Example: api_get "source_types?filter[name]=mock"
function sources_api_get {
    if [[ -z $2 ]]; then
        api_path=${SOURCES_API_BASE_PATH}
    else
        api_path=$2
    fi
    curl -H "x-rh-identity: ${X_RH_IDENTITY}" \
         --silent \
        "${SOURCES_HOST}:${SOURCES_PORT}/${api_path}/$1"
}

# Usage: api_post <path> <data>
# Example: api_post "sources" "{\"name\":\"Mock Source 1\",\"source_type_id\":\"4\"}"
function sources_api_post {
    curl --request POST \
         --header "Content-Type: application/json" \
         --header "x-rh-identity: ${X_RH_IDENTITY}" \
         --data "$2" \
         --silent \
         "${SOURCES_HOST}:${SOURCES_PORT}/${SOURCES_API_BASE_PATH}/$1"
}

# Usage: api_post <path> <data>
# Example: api_post "sources" "{\"name\":\"Mock Source 1\",\"source_type_id\":\"4\"}"
function sources_api_patch {
  echo "1: ($1)"
  echo "2: ($2)"
   curl --request PATCH \
         --header "Content-Type: application/json" \
         --header "x-rh-identity: ${X_RH_IDENTITY}" \
         --data "$2" \
         --silent \
         "${SOURCES_HOST}:${SOURCES_PORT}/${SOURCES_API_BASE_PATH}/$1"
}

# Usage: api_delete <path>
# Example: api_delete "sources/1"
function sources_api_delete {
    curl --request DELETE \
         --header "x-rh-identity: ${X_RH_IDENTITY}" \
         --silent \
         "${SOURCES_HOST}:${SOURCES_PORT}/${SOURCES_API_BASE_PATH}/$1"
}

######################################
# @param api_get response
function records_count {
    local cnt=`echo $1 | jq '.meta.count'`
    echo ${cnt}
}
