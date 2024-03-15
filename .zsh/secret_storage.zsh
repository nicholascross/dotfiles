# store_secret "MyService" "myAccount"
function store_secret() {
  local service_name="$1"
  local account_name="$2"
  echo "Enter secret value for ${service_name}:"
  
  read -s secret_value

  security add-generic-password -a "${account_name}" -s "${service_name}" -w "${secret_value}" -U
}

# retrieve_secret "MyService" "myAccount"
function retrieve_secret() {
  local service_name="$1"
  local account_name="$2"

  # Find and print the password to stdout
  security find-generic-password -a "${account_name}" -s "${service_name}" -w
}

# assign_secret_to_env "MY_SECRET_ENV" "MyService" "myAccount"
function assign_secret_to_env() {
  local env_var_name="$1"
  local service_name="$2"
  local account_name="$3"

  # Use retrieve_secret function to get the secret
  local secret_value=$(retrieve_secret "$service_name" "$account_name")

  # Assign the retrieved secret to the specified environment variable
  eval export "$env_var_name"="'$secret_value'"
}

