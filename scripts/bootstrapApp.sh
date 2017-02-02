#!/bin/bash -e

export SKIP_STEP=false

_update_install_status() {
  local update=$(cat $STATE_FILE | jq '.installStatus.'"$1"'='true'')
  _update_state "$update"
}

_check_component_status() {
  local status=$(cat $STATE_FILE | jq '.installStatus.'"$1"'')
  if [ "$status" = true ]; then
    SKIP_STEP=true;
  fi
}

generate_serviceuser_token() {
  SKIP_STEP=false
  _check_component_status "serviceuserTokenGenerated"
  if [ "$SKIP_STEP" = false ]; then
    __process_msg "Generating random token for serviceuser"
    local token=$(cat /proc/sys/kernel/random/uuid)
    local stateToken=$(cat $STATE_FILE | jq '.systemSettings.serviceUserToken="'$token'"')
    echo $stateToken > $STATE_FILE
    _update_install_status "serviceuserTokenGenerated"
  else
    __process_msg "Service user token already generated, skipping"
  fi
}

generate_root_bucket_name() {
  __process_msg "Generating root bucket name"
  local root_bucket_name=$(cat $STATE_FILE | jq -r '.systemSettings.rootS3Bucket')

  if [ "$root_bucket_name" == "" ] || [ "$root_bucket_name" == null ]; then
    __process_msg "Root bucket name not set, setting it to random value"
    local random_uuid=$(cat /proc/sys/kernel/random/uuid)
    local install_mode=$(cat $STATE_FILE | jq -r '.installMode')
    root_bucket_name="shippable-$install_mode-$random_uuid"
    root_bucket_name=$(cat $STATE_FILE | jq '.systemSettings.rootS3Bucket="'$root_bucket_name'"')
    _update_state "$root_bucket_name"
  else
    __process_msg "Root bucket name already set to: $root_bucket_name, skipping"
  fi
}

update_system_node_keys() {
  local private_key=""
  while read line; do
    private_key=$private_key""$line"\n"
  done <$SSH_PRIVATE_KEY
  local public_key=""
  while read line; do
    public_key=$public_key""$line"\n"
  done <$SSH_PUBLIC_KEY
  local update=$(cat $STATE_FILE | jq '.systemSettings.systemNodePublicKey="'$public_key'"')
  _update_state "$update"
  local update=$(cat $STATE_FILE | jq '.systemSettings.systemNodePrivateKey="'$private_key'"')
  _update_state "$update"
}

generate_system_config() {
  __process_msg "Inserting data into systemConfigs Table"

  #TODO: put sed update into a function and call it for each variable
  local system_configs_template="$USR_DIR/system_configs.sql.template"
  local system_configs_sql="$USR_DIR/system_configs.sql"

  # NOTE:
  # "sed" is using '#' as a separator in following statements
  __process_msg "Updating : defaultMinionCount"
  local default_minion_count=$(cat $STATE_FILE | jq -r '.systemSettings.defaultMinionCount')
  sed "s#{{DEFAULT_MINION_COUNT}}#$default_minion_count#g" $system_configs_template > $system_configs_sql

  __process_msg "Updating : defaultPipelineCount"
  local default_pipeline_count=$(cat $STATE_FILE | jq -r '.systemSettings.defaultPipelineCount')
  sed -i "s#{{DEFAULT_PIPELINE_COUNT}}#$default_pipeline_count#g" $system_configs_sql

  __process_msg "Updating : serverEnabled"
  local server_enabled=$(cat $STATE_FILE | jq -r '.systemSettings.serverEnabled')
  sed -i "s#{{SERVER_ENABLED}}#$server_enabled#g" $system_configs_sql

 __process_msg "Updating : autoSelectBuilderToken"
  local auto_select_builder_token=$(cat $STATE_FILE | jq -r '.systemSettings.autoSelectBuilderToken')
  sed -i "s#{{AUTO_SELECT_BUILDER_TOKEN}}#$auto_select_builder_token#g" $system_configs_sql

  __process_msg "Updating : buildTimeout"
  local build_timeout=$(cat $STATE_FILE | jq -r '.systemSettings.buildTimeoutMS')
  sed -i "s#{{BUILD_TIMEOUT_MS}}#$build_timeout#g" $system_configs_sql

  __process_msg "Updating : defaultPrivateJobQuota"
  local private_job_quota=$(cat $STATE_FILE | jq -r '.systemSettings.defaultPrivateJobQuota')
  sed -i "s#{{DEFAULT_PRIVATE_JOB_QUOTA}}#$private_job_quota#g" $system_configs_sql

  __process_msg "Updating : serviceuserToken"
  local serviceuser_token=$(cat $STATE_FILE | jq -r '.systemSettings.serviceUserToken')
  sed -i "s#{{SERVICE_USER_TOKEN}}#$serviceuser_token#g" $system_configs_sql

  __process_msg "Updating : vaultUrl"
  local vault_url=$(cat $STATE_FILE | jq -r '.systemSettings.vaultUrl')
  sed -i "s#{{VAULT_URL}}#$vault_url#g" $system_configs_sql

  __process_msg "Updating : vaultToken"
  local vault_token=$(cat $STATE_FILE | jq -r '.systemSettings.vaultToken')
  sed -i "s#{{VAULT_TOKEN}}#$vault_token#g" $system_configs_sql

  __process_msg "Updating : amqpUrl"
  local amqp_url=$(cat $STATE_FILE | jq -r '.systemSettings.amqpUrl')
  sed -i "s#{{AMQP_URL}}#$amqp_url#g" $system_configs_sql

  __process_msg "Updating : amqpUrlAdmin"
  local amqp_url_admin=$(cat $STATE_FILE | jq -r '.systemSettings.amqpUrlAdmin')
  sed -i "s#{{AMQP_URL_ADMIN}}#$amqp_url_admin#g" $system_configs_sql

  __process_msg "Updating : amqpUrlRoot"
  local amqp_url_root=$(cat $STATE_FILE | jq -r '.systemSettings.amqpUrlRoot')
  sed -i "s#{{AMQP_URL_ROOT}}#$amqp_url_root#g" $system_configs_sql

  __process_msg "Updating : amqpDefaultExchange"
  local amqp_default_exchange=$(cat $STATE_FILE | jq -r '.systemSettings.amqpDefaultExchange')
  sed -i "s#{{AMQP_DEFAULT_EXCHANGE}}#$amqp_default_exchange#g" $system_configs_sql

  __process_msg "Updating : apiUrl"
  local api_url=$(cat $STATE_FILE | jq -r '.systemSettings.apiUrl')
  sed -i "s#{{API_URL}}#$api_url#g" $system_configs_sql

  __process_msg "Updating : apiPort"
  local api_port=$(cat $STATE_FILE | jq -r '.systemSettings.apiPort')
  sed -i "s#{{API_PORT}}#$api_port#g" $system_configs_sql

  __process_msg "Updating : wwwUrl"
  local www_url=$(cat $STATE_FILE | jq -r '.systemSettings.wwwUrl')
  sed -i "s#{{WWW_URL}}#$www_url#g" $system_configs_sql

  __process_msg "Updating : runMode"
  local run_mode=$(cat $STATE_FILE | jq -r '.systemSettings.runMode')
  sed -i "s#{{RUN_MODE}}#$run_mode#g" $system_configs_sql

  __process_msg "Updating : rootQueueList"
  local root_queue_list=$(cat $STATE_FILE | jq -r '.systemSettings.rootQueueList')
  sed -i "s#{{ROOT_QUEUE_LIST}}#$root_queue_list#g" $system_configs_sql

  __process_msg "Updating : execImage"
  local exec_image=$(cat $STATE_FILE | jq -r '.systemSettings.execImage')
  sed -i "s#{{EXEC_IMAGE}}#$exec_image#g" $system_configs_sql

  __process_msg "Updating : createdAt"
  local created_at=$(date)
  sed -i "s#{{CREATED_AT}}#$created_at#g" $system_configs_sql

  __process_msg "Updating : updatedAt"
  sed -i "s#{{UPDATED_AT}}#$created_at#g" $system_configs_sql

  __process_msg "Updating : dynamicNodesSystemIntegrationId"
  local dynamic_nodes_system_integration_id=$(cat $STATE_FILE | jq -r '.systemSettings.dynamicNodesSystemIntegrationId')
  sed -i "s#{{DYNAMIC_NODES_SYSTEM_INTEGRATION_ID}}#$dynamic_nodes_system_integration_id#g" $system_configs_sql

  __process_msg "Updating : systemNodePrivateKey"
  local system_node_private_key=$(cat $STATE_FILE | jq '.systemSettings.systemNodePrivateKey' | sed s/\"//g)
  sed -i "s#{{SYSTEM_NODE_PRIVATE_KEY}}#$system_node_private_key#g" $system_configs_sql

  __process_msg "Updating : systemNodePublicKey"
  local system_node_public_key=$(cat $STATE_FILE | jq -r '.systemSettings.systemNodePublicKey')
  sed -i "s#{{SYSTEM_NODE_PUBLIC_KEY}}#$system_node_public_key#g" $system_configs_sql

  __process_msg "Updating : allowSystemNodes"
  local allow_system_nodes=$(cat $STATE_FILE | jq -r '.systemSettings.allowSystemNodes')
  sed -i "s#{{ALLOW_SYSTEM_NODES}}#$allow_system_nodes#g" $system_configs_sql

  __process_msg "Updating : allowDynamicNodes"
  local allow_dynamic_nodes=$(cat $STATE_FILE | jq -r '.systemSettings.allowDynamicNodes')
  sed -i "s#{{ALLOW_DYNAMIC_NODES}}#$allow_dynamic_nodes#g" $system_configs_sql

  __process_msg "Updating : allowCustomNodes"
  local allow_custom_nodes=$(cat $STATE_FILE | jq -r '.systemSettings.allowCustomNodes')
  sed -i "s#{{ALLOW_CUSTOM_NODES}}#$allow_custom_nodes#g" $system_configs_sql

  __process_msg "Updating : consoleMaxLifespan"
  local console_max_lifespan=$(cat $STATE_FILE | jq -r '.systemSettings.consoleMaxLifespan')
  sed -i "s#{{CONSOLE_MAX_LIFESPAN}}#$console_max_lifespan#g" $system_configs_sql

  __process_msg "Updating : consoleCleanupHour"
  local console_cleanup_hour=$(cat $STATE_FILE | jq -r '.systemSettings.consoleCleanupHour')
  sed -i "s#{{CONSOLE_CLEANUP_HOUR}}#$console_cleanup_hour#g" $system_configs_sql

  __process_msg "Updating : customHostDockerVersion"
  local custom_host_docker_version=$(cat $STATE_FILE | jq -r '.systemSettings.customHostDockerVersion')
  sed -i "s#{{CUSTOM_HOST_DOCKER_VERSION}}#$custom_host_docker_version#g" $system_configs_sql

  __process_msg "Updating : wwwPort"
  local www_port=$(cat $STATE_FILE | jq -r '.systemSettings.wwwPort')
  sed -i "s#{{WWW_PORT}}#$www_port#g" $system_configs_sql

  __process_msg "Updating : redisUrl"
  local redis_url=$(cat $STATE_FILE | jq -r '.systemSettings.redisUrl')
  sed -i "s#{{REDIS_URL}}#$redis_url#g" $system_configs_sql

  __process_msg "Updating : awsAccountId"
  local aws_account_id=$(cat $STATE_FILE | jq -r '.systemSettings.awsAccountId')
  sed -i "s#{{AWS_ACCOUNT_ID}}#$aws_account_id#g" $system_configs_sql

  __process_msg "Updating : jobConsoleBatchSize"
  local job_console_batch_size=$(cat $STATE_FILE | jq -r '.systemSettings.jobConsoleBatchSize')
  sed -i "s#{{JOB_CONSOLE_BATCH_SIZE}}#$job_console_batch_size#g" $system_configs_sql

  __process_msg "Updating : jobConsoleBufferTimeInterval"
  local job_console_buffer_time_interval=$(cat $STATE_FILE | jq -r '.systemSettings.jobConsoleBufferTimeInterval')
  sed -i "s#{{JOB_CONSOLE_BUFFER_TIME_INTERVAL}}#$job_console_buffer_time_interval#g" $system_configs_sql

  __process_msg "Updating : defaultCronLoopHours"
  local default_cron_loop_hours=$(cat $STATE_FILE | jq -r '.systemSettings.defaultCronLoopHours')
  sed -i "s#{{DEFAULT_CRON_LOOP_HOURS}}#$default_cron_loop_hours#g" $system_configs_sql

  __process_msg "Updating : apiRetryInterval"
  local api_retry_interval=$(cat $STATE_FILE | jq -r '.systemSettings.apiRetryInterval')
  sed -i "s#{{API_RETRY_INTERVAL}}#$api_retry_interval#g" $system_configs_sql

  __process_msg "Updating : vortexUrl"
  local vortex_url=$(cat $STATE_FILE | jq -r '.systemSettings.vortexUrl')
  sed -i "s#{{VORTEX_URL}}#$vortex_url#g" $system_configs_sql

  __process_msg "Updating : truck"
  local truck=$(cat $STATE_FILE | jq -r '.systemSettings.truck')
  sed -i "s#{{TRUCK}}#$truck#g" $system_configs_sql

  __process_msg "Updating : hubspotTimeLimit"
  local hubspot_time_limit=$(cat $STATE_FILE | jq -r '.systemSettings.hubspotTimeLimit')
  sed -i "s#{{HUBSPOT_TIME_LIMIT}}#$hubspot_time_limit#g" $system_configs_sql

  __process_msg "Updating : hubspotListId"
  local hubspot_list_id=$(cat $STATE_FILE | jq -r '.systemSettings.hubspotListId')
  sed -i "s#{{HUBSPOT_LIST_ID}}#$hubspot_list_id#g" $system_configs_sql

  __process_msg "Updating : hubspotShouldSimulate"
  local hubspot_should_simulate=$(cat $STATE_FILE | jq -r '.systemSettings.hubspotShouldSimulate')
  sed -i "s#{{HUBSPOT_SHOULD_SIMULATE}}#$hubspot_should_simulate#g" $system_configs_sql

  __process_msg "Updating : rootS3Bucket"
  local root_s3_bucket=$(cat $STATE_FILE | jq -r '.systemSettings.rootS3Bucket')
  sed -i "s#{{ROOT_S3_BUCKET}}#$root_s3_bucket#g" $system_configs_sql

  __process_msg "Successfully generated 'systemConfig' table data"
}

create_system_config() {
  __process_msg "Creating systemConfigs table"
  local db_host=$(cat $STATE_FILE | jq '.machines[] | select (.group=="core" and .name=="db")')
  local db_ip=$(echo $db_host | jq -r '.ip')
  local db_username=$(cat $STATE_FILE | jq -r '.systemSettings.dbUsername')

  #TODO: fetch db_name from state.json
  local db_name="shipdb"

  _copy_script_remote $db_ip "$USR_DIR/system_configs.sql" "$SCRIPT_DIR_REMOTE"
  _exec_remote_cmd $db_ip "psql -U $db_username -h $db_ip -d $db_name -v ON_ERROR_STOP=1 -f $SCRIPT_DIR_REMOTE/system_configs.sql"
  __process_msg "Successfully created systemConfigs table"
}

create_system_config_local() {
  __process_msg "Creating systemConfigs table on local db"
  local system_configs_file="$USR_DIR/system_configs.sql"
  local db_mount_dir="$LOCAL_SCRIPTS_DIR/data"

  sudo cp -vr $system_configs_file $db_mount_dir
  sudo docker exec local_postgres_1 psql -U $db_username -d $db_name -v ON_ERROR_STOP=1 -f /tmp/data/system_configs.sql

  __process_msg "Successfully created systemConfigs table on local db"
}

generate_api_config() {
  __process_msg "Generating api config"
  local release_file="$VERSIONS_DIR/$RELEASE_VERSION".json
  local api_service=$(cat $release_file | jq '.serviceConfigs[] | select (.name=="api")')

  if [ -z "$api_service" ]; then
    __process_msg "Incorrect release version, missing api configuration"
    exit 1
  fi

  local system_images_registry=$(cat $STATE_FILE | jq -r '.systemSettings.systemImagesRegistry')
  local api_service_repository=$(echo $api_service | jq -r '.repository')
  local api_service_tag=$(cat $STATE_FILE | jq -r '.deployTag')
  local api_service_image="$system_images_registry/$api_service_repository:$api_service_tag"
  __process_msg "Successfully read from state.json: api.image ($api_service_image)"

  local api_env_vars=$(cat $release_file | jq '.serviceConfigs[] | select (.name=="api") | .envs')
  echo $api_env_vars

  local api_env_vars_count=$(echo $api_env_vars | jq '. | length')
  __process_msg "Successfully read from config.json: api.envs ($api_env_vars_count)"

  __process_msg "Generating api environment variables"

  local api_env_values=""
  for i in $(seq 1 $api_env_vars_count); do
    local env_var=$(echo $api_env_vars | jq -r '.['"$i-1"']')

    if [ "$env_var" == "DBNAME" ]; then
      local db_name=$(cat $STATE_FILE | jq -r '.systemSettings.dbname')
      api_env_values="$api_env_values -e $env_var=$db_name"
    elif [ "$env_var" == "DBUSERNAME" ]; then
      local db_username=$(cat $STATE_FILE | jq -r '.systemSettings.dbUsername')
      api_env_values="$api_env_values -e $env_var=$db_username"
    elif [ "$env_var" == "DBPASSWORD" ]; then
      local db_password=$(cat $STATE_FILE | jq -r '.systemSettings.dbPassword')
      api_env_values="$api_env_values -e $env_var=$db_password"
    elif [ "$env_var" == "DBHOST" ]; then
      local db_host=$(cat $STATE_FILE | jq -r '.systemSettings.dbHost')
      api_env_values="$api_env_values -e $env_var=$db_host"
    elif [ "$env_var" == "DBPORT" ]; then
      local db_port=$(cat $STATE_FILE | jq -r '.systemSettings.dbPort')
      api_env_values="$api_env_values -e $env_var=$db_port"
    elif [ "$env_var" == "DBDIALECT" ]; then
      local db_dialect=$(cat $STATE_FILE | jq -r '.systemSettings.dbDialect')
      api_env_values="$api_env_values -e $env_var=$db_dialect"
    elif [ "$env_var" == "SHIPPABLE_API_URL" ]; then
      local db_dialect=$(cat $STATE_FILE | jq -r '.systemSettings.apiUrl')
      api_env_values="$api_env_values -e $env_var=$db_dialect"
    elif [ "$env_var" == "RUN_MODE" ]; then
      local db_dialect=$(cat $STATE_FILE | jq -r '.systemSettings.runMode')
      api_env_values="$api_env_values -e $env_var=$db_dialect"
    else
      echo "No handler for API env : $env_var, exiting"
      exit 1
    fi
  done

  http_proxy=$(cat $STATE_FILE | jq -r '.systemSettings.httpProxy')
  https_proxy=$(cat $STATE_FILE | jq -r '.systemSettings.httpsProxy')
  no_proxy=$(cat $STATE_FILE | jq -r '.systemSettings.noProxy')

  if [ ! -z $http_proxy ]; then
    api_env_values="$api_env_values -e http_proxy=$http_proxy -e HTTP_PROXY=$http_proxy"
    __process_msg "Successfully updated api http_proxy mapping"
  fi

  if [ ! -z $https_proxy ]; then
    api_env_values="$api_env_values -e https_proxy=$https_proxy -e HTTPS_PROXY=$https_proxy"
    __process_msg "Successfully updated api https_proxy mapping"
  fi

  if [ ! -z $no_proxy ]; then
    api_env_values="$api_env_values -e no_proxy=$no_proxy -e NO_PROXY=$no_proxy"
    __process_msg "Successfully updated api no_proxy mapping"
  fi

  __process_msg "Successfully generated api environment variables : $api_env_values"

  local api_service=$(cat $STATE_FILE \
    | jq '.services[] | select (.name == "api")')

  if [ -z "$api_service" ]; then
    __process_msg "no api service configuration in state file, creating all service configs from scratch"
    local api_service=$(cat $STATE_FILE |  \
      jq '.services=[
            {
              "name": "api",
              "image": "'$api_service_image'"
            }
          ]')
    update=$(echo $api_service | jq '.' | tee $STATE_FILE)
  else
    __process_msg "updating api service image"
    local api_image=$(cat $STATE_FILE | jq '
      .services |=
      map(if .name == "api" then
          .image= "'$api_service_image'"
        else
          .
        end
      )'
    )
    update=$(echo $api_image | jq '.' | tee $STATE_FILE)
  fi
  __process_msg "Successfully update api image variables"

  local api_state_env=$(cat $STATE_FILE | jq '
    .services  |=
    map(if .name == "api" then
        .env = "'$api_env_values'"
      else
        .
      end
    )'
  )
  update=$(echo $api_state_env | jq '.' | tee $STATE_FILE)
  __process_msg "Successfully generated  api environment variables"

  __process_msg "Generating api port mapping"
  local api_port=$(cat $STATE_FILE | jq -r '.systemSettings.apiPort')
  local api_port_mapping=" --publish $api_port:$api_port/tcp"
  __process_msg "api port mapping : $api_port_mapping"

  local api_port_update=$(cat $STATE_FILE | jq '
    .services  |=
    map(if .name == "api" then
        .port = "'$api_port_mapping'"
      else
        .
      end
    )'
  )
  update=$(echo $api_port_update | jq '.' | tee $STATE_FILE)
  __process_msg "Successfully updated api port mapping"

  __process_msg "Generating api service config"
  local api_service_opts=" --name api --mode global --network ingress --with-registry-auth --endpoint-mode vip"
  __process_msg "api service config : $api_service_opts"

  local api_service_update=$(cat $STATE_FILE | jq '
    .services  |=
    map(
      if .name == "api" then
        .opts = "'$api_service_opts'"
      else
        .
      end
    )'
  )
  update=$(echo $api_service_update | jq '.' | tee $STATE_FILE)
  __process_msg "Successfully generated api service config"
}

provision_api() {
  __process_msg "Provisioning api on swarm cluster"
  local swarm_manager_machine=$(cat $STATE_FILE | jq '.machines[] | select (.group=="core" and .name=="swarm")')
  local swarm_manager_host=$(echo $swarm_manager_machine | jq '.ip')

  local port_mapping=$(cat $STATE_FILE | jq -r '.services[] | select (.name=="api") | .port')
  local env_variables=$(cat $STATE_FILE | jq -r '.services[] | select (.name=="api") | .env')
  local name=$(cat $STATE_FILE | jq -r '.services[] | select (.name=="api") | .name')
  local opts=$(cat $STATE_FILE | jq -r '.services[] | select (.name=="api") | .opts')
  local image=$(cat $STATE_FILE | jq -r '.services[] | select (.name=="api") | .image')

  local boot_api_cmd="docker service create \
    $port_mapping \
    $env_variables \
    $opts $image"

  local rm_api_cmd="docker service rm api || true"

  _exec_remote_cmd "$swarm_manager_host" "$rm_api_cmd"
  __process_msg "waiting 20 seconds for api to shut down "
  sleep 20
  _exec_remote_cmd "$swarm_manager_host" "$boot_api_cmd"

  __process_msg "Successfully provisioned api"
}

provision_api_local() {
  __process_msg "Provisioning api on local machine"

  local port_mapping=$(cat $STATE_FILE | jq -r '.services[] | select (.name=="api") | .port')
  local env_variables=$(cat $STATE_FILE | jq -r '.services[] | select (.name=="api") | .env')
  local name=$(cat $STATE_FILE | jq -r '.services[] | select (.name=="api") | .name')
  local opts=$(cat $STATE_FILE | jq -r '.services[] | select (.name=="api") | .opts')
  local image=$(cat $STATE_FILE | jq -r '.services[] | select (.name=="api") | .image')

  sudo docker rm -f api || true

  # Pull image before attempting to run to ensure the image is always updated in
  # case it was overwritten. Like in case of :latest.
  local pull_api_cmd="sudo docker pull $image"
  __process_msg "Pulling $image..."
  local pull_result=$(eval $pull_api_cmd)

  local boot_api_cmd="sudo docker run -d \
    $port_mapping \
    $env_variables \
    --net host \
    --name api
    $image"

  local result=$(eval $boot_api_cmd)

  __process_msg "Successfully provisioned api"
}

check_api_health() {
  __process_msg "Checking API health"
  source "$SCRIPTS_DIR/_checkApiHealth.sh"
}

run_migrations() {
  __process_msg "Running migrations.sql"

  local db_host=$(cat $STATE_FILE | jq '.machines[] | select (.group=="core" and .name=="db")')
  local db_ip=$(echo $db_host | jq -r '.ip')
  local db_username=$(cat $STATE_FILE | jq -r '.systemSettings.dbUsername')
  local db_name="shipdb"

  local migrations_file_path="$MIGRATIONS_DIR/$RELEASE_VERSION.sql"
  if [ ! -f $migrations_file_path ]; then
    __process_msg "No migrations found for this release, skipping"
  else
    local migrations_file_name=$(basename $migrations_file_path)
    _copy_script_remote $db_ip $migrations_file_path "$SCRIPT_DIR_REMOTE"
    _exec_remote_cmd $db_ip "psql -U $db_username -h $db_ip -d $db_name -v ON_ERROR_STOP=1 -f $SCRIPT_DIR_REMOTE/$migrations_file_name"
  fi
}

run_migrations_local() {
  __process_msg "Running migrations.sql"

  local db_username=$(cat $STATE_FILE | jq -r '.systemSettings.dbUsername')
  local db_name="shipdb"

  ##TODO: this should be the latest release file
  ##TODO update the version in state after migration is run
  local migrations_file="$MIGRATIONS_DIR/$RELEASE_VERSION.sql"
  if [ ! -f $migrations_file ]; then
    __process_msg "No migrations found for this release, skipping"
  else
    local db_mount_dir="$LOCAL_SCRIPTS_DIR/data/migrations.sql"
    sudo cp -vr $migrations_file $db_mount_dir
    sudo docker exec local_postgres_1 psql -U $db_username -d $db_name -v ON_ERROR_STOP=1 -f /tmp/data/migrations.sql
  fi
}

manage_masterIntegrations() {
  __process_msg "Configuring master integrations"
  source "$SCRIPTS_DIR/_manageMasterIntegrations.sh"
}

manage_systemIntegrations() {
  __process_msg "Configuring system integrations"
  source "$SCRIPTS_DIR/_manageSystemIntegrations.sh"
}

manage_systemMachineImages() {
  __process_msg "Configuring system machine images"
  source "$SCRIPTS_DIR/_manageSystemMachineImages.sh"
}

update_dynamic_nodes_integration_id() {
  __process_msg "Updating dynamic node system integartion id"
  local api_url=""
  local api_token=$(cat $STATE_FILE | jq -r '.systemSettings.serviceUserToken')
  local api_url=$(cat $STATE_FILE | jq -r '.systemSettings.apiUrl')
  local system_integration_endpoint="$api_url/systemIntegrations"

  local query="?masterType=cloudproviders&name=AWS-ROOT"
  local system_integrations=$(curl \
    -H "Content-Type: application/json" \
    -H "Authorization: apiToken $api_token" \
    -X GET $system_integration_endpoint$query \
    --silent)

    local system_integrations_length=$(echo $system_integrations | jq -r '. | length')
    if [ $system_integrations_length -gt 0 ]; then
      local system_integration=$(echo $system_integrations | jq '.[0]')
      local system_integration_id=$(echo $system_integration | jq -r '.id')
      local update=$(cat $STATE_FILE | jq '.systemSettings.dynamicNodesSystemIntegrationId="'$system_integration_id'"')
      _update_state "$update"
    else
      __process_msg "No system integration configured for dynamic nodes, skipping"
    fi
  __process_msg "Successfully updated dynamic node system integartion id"
}


restart_api() {
  __process_msg "Restarting API..."
  local swarm_manager_machine=$(cat $STATE_FILE | jq '.machines[] | select (.group=="core" and .name=="swarm")')
  local swarm_manager_host=$(echo $swarm_manager_machine | jq '.ip')

  local port_mapping=$(cat $STATE_FILE | jq -r '.services[] | select (.name=="api") | .port')
  local env_variables=$(cat $STATE_FILE | jq -r '.services[] | select (.name=="api") | .env')
  local name=$(cat $STATE_FILE | jq -r '.services[] | select (.name=="api") | .name')
  local opts=$(cat $STATE_FILE | jq -r '.services[] | select (.name=="api") | .opts')
  local image=$(cat $STATE_FILE | jq -r '.services[] | select (.name=="api") | .image')

  local boot_api_cmd="docker service create \
    $port_mapping \
    $env_variables \
    $opts $image"

  local rm_api_cmd="docker service rm api || true"

  _exec_remote_cmd "$swarm_manager_host" "$rm_api_cmd"

  __process_msg "Waiting 30s before API restart..."
  sleep 30

  _exec_remote_cmd "$swarm_manager_host" "$boot_api_cmd"
}

restart_api_local() {
  __process_msg "Restarting API..."
  local port_mapping=$(cat $STATE_FILE | jq -r '.services[] | select (.name=="api") | .port')
  local env_variables=$(cat $STATE_FILE | jq -r '.services[] | select (.name=="api") | .env')
  local name=$(cat $STATE_FILE | jq -r '.services[] | select (.name=="api") | .name')
  local opts=$(cat $STATE_FILE | jq -r '.services[] | select (.name=="api") | .opts')
  local image=$(cat $STATE_FILE | jq -r '.services[] | select (.name=="api") | .image')

  sudo docker rm -f api || true
  local boot_api_cmd="sudo docker run -d \
      $port_mapping \
      $env_variables \
      --net host \
      --name api
      $image"

  local result=$(eval $boot_api_cmd)
}

update_service_list() {
  __process_msg "configuring services according to master integrations"
  source "$SCRIPTS_DIR/_manageServices.sh"
}

__map_env_vars() {
  if [ "$1" == "DBNAME" ]; then
    env_value=$(cat $STATE_FILE | jq -r '.systemSettings.dbname')
  elif [ "$1" == "DBUSERNAME" ]; then
    env_value=$(cat $STATE_FILE | jq -r '.systemSettings.dbUsername')
  elif [ "$1" == "DBPASSWORD" ]; then
    env_value=$(cat $STATE_FILE | jq -r '.systemSettings.dbPassword')
  elif [ "$1" == "DBHOST" ]; then
    env_value=$(cat $STATE_FILE | jq -r '.systemSettings.dbHost')
  elif [ "$1" == "DBPORT" ]; then
    env_value=$(cat $STATE_FILE | jq -r '.systemSettings.dbPort')
  elif [ "$1" == "DBDIALECT" ]; then
    env_value=$(cat $STATE_FILE | jq -r '.systemSettings.dbDialect')
  elif [ "$1" == "SHIPPABLE_API_TOKEN" ]; then
    env_value=$(cat $STATE_FILE | jq -r '.systemSettings.serviceUserToken')
  elif [ "$1" == "SHIPPABLE_VORTEX_URL" ]; then
    env_value=$(cat $STATE_FILE | jq -r '.systemSettings.apiUrl')/vortex
  elif [ "$1" == "SHIPPABLE_API_URL" ]; then
    env_value=$(cat $STATE_FILE | jq -r '.systemSettings.apiUrl')
  elif [ "$1" == "SHIPPABLE_WWW_PORT" ]; then
    env_value=50001
  elif [ "$1" == "SHIPPABLE_WWW_URL" ]; then
    env_value=$(cat $STATE_FILE | jq -r '.systemSettings.wwwUrl')
  elif [ "$1" == "SHIPPABLE_FE_URL" ]; then
    env_value=$(cat $STATE_FILE | jq -r '.systemSettings.wwwUrl')
  elif [ "$1" == "LOG_LEVEL" ]; then
    env_value=info
  elif [ "$1" == "SHIPPABLE_RDS_URL" ]; then
    env_value=$(cat $STATE_FILE | jq -r '.systemSettings.redisUrl')
  elif [ "$1" == "SHIPPABLE_ROOT_AMQP_URL" ]; then
    env_value=$(cat $STATE_FILE | jq -r '.systemSettings.amqpUrlRoot')
  elif [ "$1" == "SHIPPABLE_AMQP_DEFAULT_EXCHANGE" ]; then
    env_value=$(cat $STATE_FILE | jq -r '.systemSettings.amqpDefaultExchange')
  elif [ "$1" == "RUN_MODE" ]; then
    env_value=$(cat $STATE_FILE | jq -r '.systemSettings.runMode')
  # TODO: Populate this
  elif [ "$1" == "DOCKER_VERSION" ]; then
    env_value=1.9.1
  elif [ "$1" == "DEFAULT_CRON_LOOP_HOURS" ]; then
    env_value=2
  elif [ "$1" == "API_RETRY_INTERVAL" ]; then
    env_value=3
  elif [ "$1" == "PROVIDERS" ]; then
    env_value=ec2
  elif [ "$1" == "SHIPPABLE_EXEC_IMAGE" ]; then
    local step_exec_image=$(cat $STATE_FILE | jq -r '.systemSettings.stepExecImage')
    env_value=$step_exec_image
  elif [ "$1" == "EXEC_IMAGE" ]; then
    local step_exec_image=$(cat $STATE_FILE | jq -r '.systemSettings.stepExecImage')
    env_value=$step_exec_image
  elif [ "$1" == "SETUP_RUN_SH" ]; then
    env_value=true
  elif [ "$1" == "SHIPPABLE_AWS_ACCOUNT_ID" ]; then
    local shippable_aws_account_id=$(cat $STATE_FILE | jq -r '.systemSettings.shippableAwsAccountId')
    env_value=$shippable_aws_account_id
  elif [ "$1" == "GITHUB_LINK_SYSINT_ID" ]; then
    env_value=null
  # TODO: Populate this
  elif [ "$1" == "BITBUCKET_LINK_SYSINT_ID" ]; then
    env_value=null
  elif [ "$1" == "BITBUCKET_CLIENT_ID" ]; then
    env_value=null
  elif [ "$1" == "BITBUCKET_CLIENT_SECRET" ]; then
    env_value=null
  elif [ "$1" == "COMPONENT" ]; then
    env_value=$2
  elif [ "$1" == "JOB_TYPE" ]; then
    env_value=$3
  elif [ "$1" == "TRUCK" ]; then
    env_value=true
  elif [ "$1" == "IRC_BOT_NICK" ]; then
    env_value=$(cat $STATE_FILE | jq -r '.systemSettings.ircBotNick')
  elif [ "$1" == "SHIP_TIME_LIMIT" ]; then
    env_value=$(cat $STATE_FILE | jq -r '.systemSettings.hubspotShipTimeLimit')
  elif [ "$1" == "HUBSPOT_LIST_ID" ]; then
    env_value=$(cat $STATE_FILE | jq -r '.systemSettings.hubspotListId')
  elif [ "$1" == "SHOULD_SIMULATE" ]; then
    env_value=$(cat $STATE_FILE | jq -r '.systemSettings.hubspotShouldSimulate')
  else
    echo "No handler for env : $1, exiting"
    exit 1
  fi
}

__pull_image_globally() {
  local service_image="$1"
  __process_msg "Pulling service image on all service machines: $service_image"
  local service_machines_list=$(cat $STATE_FILE \
    | jq '[ .machines[] | select(.group=="services") ]')
  local service_machines_count=$(echo $service_machines_list \
    | jq '. | length')

  if [ $service_machines_count -gt 0 ]; then
    for i in $(seq 1 $service_machines_count); do
      local machine=$(echo $service_machines_list \
        | jq '.['"$i-1"']')
      local host=$(echo $machine \
        | jq '.ip')
      __process_msg "Pulling image: $service_image on host: $host"
      local pull_command="sudo su -c \'docker pull $service_image\'"
      _exec_remote_cmd "$host" "$pull_command"
      __process_msg "Successfully pulled image: $service_image on host: $host"
    done
  else
    __process_msg "No service machines configured to pull images"
  fi
}

__save_service_config() {
  local service=$1
  local ports=$2
  local opts=$3
  local component=$4
  local job_type=$5

  __process_msg "Saving image for $service"
  local system_images_registry=$(cat $STATE_FILE | jq -r '.systemSettings.systemImagesRegistry')
  local service_repository=$(cat $release_file | jq -r --arg service "$service" '
    .serviceConfigs[] |
    select (.name==$service) | .repository')
  #local service_tag=$service"."$RELEASE_VERSION
  local service_tag=$(cat $STATE_FILE \
      | jq -r '.deployTag')
  local service_image="$system_images_registry/$service_repository:$service_tag"
  __process_msg "Image version generated for $service : $service_image"
  local image_update=$(cat $STATE_FILE | jq --arg service "$service" '
    .services  |=
    map(if .name == "'$service'" then
        .image = "'$service_image'"
      else
        .
      end
    )'
  )
  update=$(echo $image_update | jq '.' | tee $STATE_FILE)
  __process_msg "Successfully updated $service image"

  __process_msg "Saving config for $service"
  local env_vars=$(cat $release_file | jq --arg service "$service" '
    .serviceConfigs[] |
    select (.name==$service) | .envs')
  __process_msg "Found envs for $service: $env_vars"

  local env_vars_count=$(echo $env_vars | jq '. | length')
  __process_msg "Successfully read from version file: $service.envs ($env_vars_count)"

  env_values=""
  for i in $(seq 1 $env_vars_count); do
    local env_var=$(echo $env_vars | jq -r '.['"$i-1"']')

    # Never apply TRUCK env in production mode
    if [ "$env_var" == "TRUCK" ] && [ "$INSTALL_MODE" == "production" ]; then
      continue
    fi

    if [ "$env_var" == "JOB_TYPE" ] || \
      [ "$env_var" == "COMPONENT" ]; then

      if [ $service == "deploy" ] || [ $service == "manifest" ] \
        || [ $service == "provision" ] || [ $service == "release" ] \
        || [ $service == "rSync" ]; then
          __map_env_vars $env_var "stepExec" "$service"
        env_values="$env_values -e $env_var=$env_value"
      else
        __map_env_vars $env_var $component $job_type
        env_values="$env_values -e $env_var=$env_value"
      fi
    else
      __map_env_vars $env_var $component $job_type
      env_values="$env_values -e $env_var=$env_value"
    fi

  done

  # Proxy
  __process_msg "Adding $service proxy mapping"
  http_proxy=$(cat $STATE_FILE | jq -r '.systemSettings.httpProxy')
  https_proxy=$(cat $STATE_FILE | jq -r '.systemSettings.httpsProxy')
  no_proxy=$(cat $STATE_FILE | jq -r '.systemSettings.noProxy')

  if [ ! -z $http_proxy ]; then
    env_values="$env_values -e http_proxy=$http_proxy -e HTTP_PROXY=$http_proxy"
    __process_msg "Successfully updated $service http_proxy mapping"
  fi

  if [ ! -z $https_proxy ]; then
    env_values="$env_values -e https_proxy=$https_proxy -e HTTPS_PROXY=$https_proxy"
    __process_msg "Successfully updated $service https_proxy mapping"
  fi

  if [ ! -z $no_proxy ]; then
    env_values="$env_values -e no_proxy=$no_proxy -e NO_PROXY=$no_proxy"
    __process_msg "Successfully updated $service no_proxy mapping"
  fi

  local state_env=$(cat $STATE_FILE | jq --arg service "$service" '
    .services  |=
    map(if .name == $service then
        .env = "'$env_values'"
      else
        .
      end
    )'
  )
  update=$(echo $state_env | jq '.' | tee $STATE_FILE)

  local volumes=$(cat $release_file | jq --arg service "$service" '
    .serviceConfigs[] |
    select (.name==$service) | .volumes')
  if [ "$volumes" != "null" ]; then
    local volumes_update=""
    local volumes_count=$(echo $volumes | jq '. | length')
    for i in $(seq 1 $volumes_count); do
      local volume=$(echo $volumes | jq -r '.['"$i-1"']')
      volumes_update="$volumes_update -v $volume"
    done
    volumes_update=$(cat $STATE_FILE | jq --arg service "$service" '
      .services  |=
      map(if .name == $service then
          .volumes = "'$volumes_update'"
        else
          .
        end
      )'
    )
    update=$(echo $volumes_update | jq '.' | tee $STATE_FILE)
    __process_msg "Successfully updated $service volumes"
  fi

  # Ports
  # TODO: Fetch from systemConfig
  local port_mapping=$ports

  if [ ! -z $ports ]; then
    __process_msg "Generating $service port mapping"
    __process_msg "$service port mapping : $port_mapping"
    local port_update=$(cat $STATE_FILE | jq --arg service "$service" '
      .services  |=
      map(if .name == $service then
          .port = "'$port_mapping'"
        else
          .
        end
      )'
    )
    update=$(echo $port_update | jq '.' | tee $STATE_FILE)
    __process_msg "Successfully updated $service port mapping"
  fi

  # Opts
  # TODO: Fetch from systemConfig
  local opts=$3
  __process_msg "$service opts : $opts"

  if [ ! -z $opts ]; then
    __process_msg "Generating $service opts"
    local opt_update=$(cat $STATE_FILE | jq --arg service "$service" '
      .services  |=
      map(if .name == $service then
          .opts = "'$opts'"
        else
          .
        end
      )'
    )
    update=$(echo $opt_update | jq '.' | tee $STATE_FILE)
    __process_msg "Successfully updated $service opts"
  fi
}

save_service_config() {
  local services=$(cat $STATE_FILE | jq -c '[ .services[] ]')
  local services_count=$(echo $services | jq '. | length')
  for i in $(seq 1 $services_count); do
    local service=$(echo $services | jq -r '.['"$i-1"'] | .name')
    __save_service_config $service "" " --name $service --network ingress --with-registry-auth --endpoint-mode vip" $service
  done
}

pull_images() {
  local services=$(cat $STATE_FILE | jq -c '[ .services[] ]')
  local pulled_images="[]"
  local services_count=$(echo $services | jq '. | length')
  for i in $(seq 1 $services_count); do
    local service=$(echo $services | jq -r '.['"$i-1"'] | .name')
    local service_image=$(cat $STATE_FILE \
      | jq -r '.services[] | select (.name=="'$service'") | .image')
    local is_image_pulled=$(echo $pulled_images | jq -r '.[] | select (.=="'$service_image'")')
    if [ -z "$is_image_pulled" ]; then
      pulled_images=$(echo $pulled_images | jq '. + ["'$service_image'"]')
      __pull_image_globally "$service_image"
    else
      __process_msg "Skipping $service_image image pull for service $service as its already pulled"
    fi
  done
}

__stop_state_less_service() {
  service=$1
  local swarm_manager_machine=$(cat $STATE_FILE | jq '.machines[] | select (.group=="core" and .name=="swarm")')
  local swarm_manager_host=$(echo $swarm_manager_machine | jq '.ip')
  _exec_remote_cmd "$swarm_manager_host" "docker service rm $service || true"
}

stop_state_less_services() {
  local services=$(cat $STATE_FILE | jq -c '[ .services[] ]')
  local services_count=$(echo $services | jq '. | length')

  # www and api are statefull services
  local state_full_services="[\"www\",\"api\"]"

  for i in $(seq 1 $services_count); do
    local service=$(echo $services | jq -r '.['"$i-1"'] | .name')
    local state_full_service=$(echo $state_full_services | jq -r '.[] | select (.=="'$service'")')
    if [ -z "$state_full_service" ]; then
      __stop_state_less_service "$service"
    fi
  done
}

main() {
  __process_marker "Updating system config"
  generate_serviceuser_token
  generate_root_bucket_name

  local is_upgrade=$(cat $STATE_FILE | jq -r '.isUpgrade')
  if [ "$INSTALL_MODE" == "production" ]; then
    update_service_list
    save_service_config
    pull_images
    update_system_node_keys
    generate_system_config
    create_system_config
    if [ $is_upgrade = true ]; then
      run_migrations
    fi
    generate_api_config
    stop_state_less_services
    provision_api
    check_api_health
    run_migrations
    if [ $is_upgrade = false ]; then
      restart_api
      check_api_health
    fi
    manage_masterIntegrations
    manage_systemIntegrations
    manage_systemMachineImages
    update_dynamic_nodes_integration_id
    generate_system_config
    create_system_config
    restart_api
  else
    update_service_list
    save_service_config
    update_system_node_keys
    generate_system_config
    create_system_config_local
    if [ $is_upgrade = true ]; then
      run_migrations_local
    fi
    generate_api_config
    provision_api_local
    check_api_health
    run_migrations_local
    if [ $is_upgrade = false ]; then
      restart_api_local
      check_api_health
    fi
    manage_masterIntegrations
    manage_systemIntegrations
    manage_systemMachineImages
    update_dynamic_nodes_integration_id
    generate_system_config
    create_system_config_local
    restart_api_local
  fi

  check_api_health
}

main
