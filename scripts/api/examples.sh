#!/usr/bin/env bash

source "api/common.sh"

#
# LIST tenants ------------------
#
# sources_api_get "tenants" "internal/v1.0"
# echo ""
# api_get "tenants" "internal/v0.0"
# echo ""
#
# SOURCES --------------------
#
# GET Source Type
# response=`sources_api_get "source_types?filter[name]=amazon"`
# echo ${response} | jq '.'
#
# GET Sources
# sources_api_get 'sources'
# echo ""
# topological_api_get 'sources'
# echo ""

# CREATE Source
# sources_api_post "sources" "{\"name\":\"Mock Source 1\",\"source_type_id\":\"4\"}"
# echo ""
#

# UPDATE Source
# sources_api_patch "sources/2" "{\"name\": \"Openshift Source\"}"
# echo ""
#

# DELETE Source
# sources_api_delete "sources/1"
# echo ""
#

# APPLICATIONS (complex filter) -----

# GET applications which must be added (at least 1) to Source for creating Collector's pod
# sources_api_get "applications?filter[application_type_id][eq][]=1&filter[application_type_id][eq][]=3"
# echo ""

# GRAPHQL -----------------------

# sources_api_post "graphql" "{\"query\": \"{ sources { id, created_at, source_type_id, name, tenant, uid, updated_at applications { application_type_id, id }, endpoints { id, scheme, host, port, path } }}\"}"


# CATALOG ORDERING --------------
# Job template
# topological_api_post "service_plans/2/order" "{\"service_parameters\":{\"username\":\"mslemr\",\"quest\":\"Test Topology\",\"airspeed\":50},\"provider_control_parameters\":{}}"

# Workflow Job template
# topological_api_post "service_plans/5/order" "{\"service_parameters\":{\"dev_null\":\"Yes\"},\"provider_control_parameters\":{}}"
