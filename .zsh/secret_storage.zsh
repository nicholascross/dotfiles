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

function enforce_secret() {
  local service_name="$1"
  local account_name="$2"

  # Check if the secret already exists
  if retrieve_secret "${service_name}" "${account_name}" > /dev/null 2>&1; then
    return 0
  fi

  # If the secret doesn't exist, store a new one
  store_secret "${service_name}" "${account_name}"
}

