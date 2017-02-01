#!/bin/bash -e

release_file="$VERSIONS_DIR/$RELEASE_VERSION".json

__add_service() {
  local service_name="$1"

  local service=$(cat $release_file \
    | jq -c '.serviceConfigs[] | select (.name=='$service_name')')

  if [ ! -z "$service" ]; then
    __process_msg "service $service_name present in release file"
    local service_state=$(cat $STATE_FILE \
      | jq '.services[] | select (.name=='$service_name')')

    if [ -z "$service_state" ]; then
      __process_msg "no $service_name service in state.json, creating new one"
      local is_service_global=$(echo $service \
        | jq -r '.isGlobal')

      if [ "$is_service_global" == true ]; then
        __process_msg "service $service_name is global, not setting default replica count"
        service_state=$(cat $STATE_FILE |  \
          jq '.services |= . + [{
            "name": '$service_name',
            "image": "",
            "env": ""
          }]')
      else
        __process_msg "service $service_name not global, setting default replica count"
        service_state=$(cat $STATE_FILE |  \
          jq '.services |= . + [{
            "name": '$service_name',
            "image": "",
            "env": "",
            "replicas": 1
          }]')
      fi
      update=$(echo $service_state | jq '.' | tee $STATE_FILE)
    else
      __process_msg "service $service_name already present in state file"
    fi
  else
    __process_msg "Error!!! service $service_name not present in release file"
    exit 1
  fi
}

remove_services() {
  local services="$(cat $STATE_FILE | jq -c '[ .services[] ]')"
  local services_count=$(echo $services | jq '. | length')
  local master_integrations="$(cat $STATE_FILE | jq -c '[ .masterIntegrations[] ]')"
  local master_integration_services="[]"
  local master_integrations_count=$(echo $master_integrations | jq '. | length')
  for i in $(seq 1 $master_integrations_count); do
    local master_integration=$(echo $master_integrations | jq '.['"$i-1"'] | .name')
    local integration_services=$(cat $release_file | jq -c '[ .integrationServices[] | select( .name=='$master_integration' ) | .services[] ]')
    master_integration_services=$(echo $master_integration_services | \
          jq '. |= . + '$integration_services'')
  done
  local indices_del="[]"
  for i in $(seq 1 $services_count); do
    local service=$(echo $services | jq '.['"$i-1"'] | .name')
    local service_present=$(echo $master_integration_services | jq '.[] | select (.=='$service')')
    if [ -z "$service_present" ]; then
      local core_services=$(cat $release_file | jq '.coreServices')
      service_present=$(echo $core_services | jq '.[] | select (.=='$service')')
      if [ -z "$service_present" ]; then
        indices_del=$(echo $indices_del | \
          jq '. |= . + ['"$i-1"']')
      fi
    fi
  done
  local indices_del_length=$(echo $indices_del | jq '. | length')
  local counter=$((indices_del_length - 1))
  while [ $counter -ge 0 ]; do
    local index=$(echo $indices_del | jq '.['$counter']')
    services=$(echo $services | jq -c 'del(.['$index'])')
    counter=$((counter-1))
  done

  local update=$(cat $STATE_FILE | jq '.services='$services'')
  _update_state "$update"
}

add_core_services() {
  local core_services=$(cat $release_file | jq '.coreServices')
  local core_services_count=$(echo $core_services | jq '. | length')
  for i in $(seq 1 $core_services_count); do
    local core_service=$(echo $core_services | jq '.['"$i-1"']')
    __add_service "$core_service"
  done
}

add_master_integration_services() {
  local master_integrations=$(cat $STATE_FILE | jq '.masterIntegrations')
  local master_integrations_count=$(echo $master_integrations | jq '. | length')
  for i in $(seq 1 $master_integrations_count); do
    local master_integration_service=$(echo $master_integrations | jq '.['"$i-1"'] | .name')
    local integration_services=$(cat $release_file | jq -c '[ .integrationServices[] | select (.name == '$master_integration_service') | .services[] ]')
    local integration_services_count=$(echo $integration_services | jq '. | length')
    for i in $(seq 1 $integration_services_count); do
      local service=$(echo $integration_services | jq '.['"$i-1"']')
      __add_service "$service"
    done
  done
}

configure_replicas() {
  __process_msg "Configuring replicas for services"
  local replicas_configured=$(cat $STATE_FILE | jq -r '.installStatus.replicasConfigured')

  if [ $replicas_configured == true ]; then
    __process_msg "Service replicas already configured, skipping"
  else
    __process_msg "Service replicas configuration required"
    __process_msg "Please set the desired replica count in 'services[]' array in 'usr/state.json' file"
    __process_msg "Once completed, set 'installStatus.replicasConfigured=true' and re-run installer"
    exit 1
  fi
}

main() {
  __process_marker "Configuring services list"

  remove_services
  add_core_services
  add_master_integration_services
  configure_replicas
  __process_msg "Configured services list"
}

main
