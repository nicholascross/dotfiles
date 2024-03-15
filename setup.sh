#!/usr/bin/env zsh

# Directory containing scripts that do not require sudo
normal_scripts_dir="$HOME/.setup/normal"

# Directory containing scripts that require sudo
sudo_scripts_dir="$HOME/.setup/sudo"

# Function to run normal scripts
run_normal_scripts() {
    for script in $normal_scripts_dir/*.{sh,zsh}(N); do
        echo "Running script: $script"
        zsh $script
    done
}

# Function to run sudo scripts
run_sudo_scripts() {
    for script in $sudo_scripts_dir/*.{sh,zsh}(N); do
        echo "About to run a script with sudo: $script"
        echo "Please review the script before continuing."
        read "?Press Enter to continue or Ctrl+C to abort."
        sudo zsh $script
    done
}

# Run the functions
run_normal_scripts
run_sudo_scripts

