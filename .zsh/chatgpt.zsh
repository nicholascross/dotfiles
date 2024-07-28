#!/bin/bash

. ~/.zsh/secret_storage.zsh

# Function to send request to OpenAI API
send_request() {
  enforce_secret 'openai' 'token'
  API_KEY="$(retrieve_secret 'openai' 'token')"

  local query=$1
  local api_url="https://api.openai.com/v1/chat/completions"

  response=$(curl -s -X POST $api_url \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $API_KEY" \
    -d '{
      "model": "gpt-4o",
      "messages": [{"role": "system", "content": "Behave as expert system that outputs consise and accurate information.  If something is unknown it will not attempt to guess.  Ensure the command is efficient and suitable for a typical macOS environment that uses zsh."},{"role": "user", "content": "'"$query"'"}]
    }')

    RESPONSE="$(echo -E $response | jq '.choices[0].message.content')"
    echo "$RESPONSE" | tr -d "\"" | glow -s "$HOME/.zsh/glow_tokyonight.json"
  }

# Function to suggest a command
suggest_command() {
  local task=$1
  query="A shell command to achieve the following: $task. "
  send_request "$query"
}

# Function to explain a command
explain_command() {
  local command=$1
  query="Explan the following shell command: $command. Include the purpose of the command, a brief description of the options used, and any important considerations or typical use cases."
  send_request "$query"
}

# Display usage
usage() {
  echo "Usage: $0 [suggest|explain] [task|command]"
  return 1
}

chat() {
  # Check if jq is installed
  if ! command -v jq &> /dev/null; then
    echo "jq is required but not installed. Please install jq to proceed."
    exit 1
  fi

  if ! command -v glow &> /dev/null; then
    echo "glow is required but not installed. Please install glow to proceed."
    exit 1
  fi
  
  # Check if correct number of arguments are provided
  if [ "$#" -ne 2 ]; then
    usage
  fi

  # Parse arguments
  operation=$1
  input=$2

  case $operation in
    suggest)
      suggest_command "$input"
      ;;
    explain)
      explain_command "$input"
      ;;
    *)
      usage
      ;;
  esac
}
