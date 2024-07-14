# Generic plugin installation
# clone if the plugin not already installed
# source the plugin file
install_plugin() {
  local plugin_name=$1
  local repo_url=$2
  local plugin_dir="${HOME}/.zsh/${plugin_name}"

  if [[ ! -d "${plugin_dir}" ]]; then
    echo "Installing ${plugin_name}..."
    git clone ${repo_url} ${plugin_dir}
  fi
  
  source "${plugin_dir}/${plugin_name}.plugin.zsh"
}

install_plugin "history-search-multi-word" "https://github.com/zdharma-continuum/history-search-multi-word"
install_plugin "fast-syntax-highlighting" "https://github.com/zdharma-continuum/fast-syntax-highlighting"
