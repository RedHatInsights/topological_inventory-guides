#!/usr/bin/env bash

source "api/common.sh"
#
# LIST tenants ------------------
#
# topological_api_get "tenants?filter[id]=2" "internal/v1.0"
# echo ""
# topological_api_get "tenants" "internal/v0.0"
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
# topological_api_post "service_offerings/2/order" "{\"service_parameters\":{\"username\":\"mslemr\",\"quest\":\"Test Topology\",\"airspeed\":50},\"provider_control_parameters\":{}}"

# Workflow Job template
# topological_api_post "service_offerings/5/order" "{\"service_parameters\":{\"dev_null\":\"Yes\"},\"provider_control_parameters\":{}}"

#topological_api_post "service_offerings/3/order" "{\"provider_control_parameters\":{}}"

#topological_api_post "service_offerings/569/applied_inventories" "{}"

#sources_api_post "sources" "{\"uid\": \"1111\",\"name\":\"Azure 1\",\"source_type_id\":\"3\", \"availability_status\": \"available\"}"
#sources_api_post "sources" "{\"uid\": \"2222\",\"name\":\"Azure 2\",\"source_type_id\":\"3\", \"availability_status\": \"available\"}"
#sources_api_post "sources" "{\"uid\": \"3333\",\"name\":\"Azure 3\",\"source_type_id\":\"3\", \"availability_status\": \"available\"}"
#sources_api_post "sources" "{\"uid\": \"4444\",\"name\":\"Azure 4\",\"source_type_id\":\"3\", \"availability_status\": \"available\"}"
#sources_api_post "endpoints" "{\"source_id\":\"9\",\"default\":\"true\",\"path\":\"/\"}"
#sources_api_post "endpoints" "{\"source_id\":\"10\",\"default\":\"true\",\"path\":\"/\"}"
#sources_api_post "endpoints" "{\"source_id\":\"11\",\"default\":\"true\",\"path\":\"/\"}"
#sources_api_post "authentications" "{\"resource_type\":\"Endpoint\",\"resource_id\":\"6\",\"authtype\":\"tenant_id_client_id_client_secret\",\"username\":\"redhat\",\"password\":\"redhat\",\"extra\":{\"azure\":{\"tenant_id\":\"12345\"}}}"
#sources_api_post "authentications" "{\"resource_type\":\"Endpoint\",\"resource_id\":\"7\",\"authtype\":\"tenant_id_client_id_client_secret\",\"username\":\"redhat\",\"password\":\"redhat\",\"extra\":{\"azure\":{\"tenant_id\":\"12345\"}}}"
#sources_api_post "authentications" "{\"resource_type\":\"Endpoint\",\"resource_id\":\"8\",\"authtype\":\"tenant_id_client_id_client_secret\",\"username\":\"redhat\",\"password\":\"redhat\",\"extra\":{\"azure\":{\"tenant_id\":\"12345\"}}}"
#sources_api_post "authentications" "{\"resource_type\":\"Endpoint\",\"resource_id\":\"9\",\"authtype\":\"tenant_id_client_id_client_secret\",\"username\":\"redhat\",\"password\":\"redhat\",\"extra\":{\"azure\":{\"tenant_id\":\"12345\"}}}"
#sources_api_post "applications" "{\"source_id\":\"8\",\"application_type_id\":\"4\",\"availability_status\":\"available\"}"
#sources_api_post "applications" "{\"source_id\":\"9\",\"application_type_id\":\"4\",\"availability_status\":\"available\"}"
#sources_api_post "applications" "{\"source_id\":\"10\",\"application_type_id\":\"4\",\"availability_status\":\"available\"}"
sources_api_post "applications" "{\"source_id\":\"11\",\"application_type_id\":\"4\",\"availability_status\":\"available\"}"
echo ""