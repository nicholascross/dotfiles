# Load or install plugins
source $HOME/.zsh/plugins/install.zsh

# Load all configuration
for config_file ($HOME/.zsh/*.zsh); do
  source $config_file
done

