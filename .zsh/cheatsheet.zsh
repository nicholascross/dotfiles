# Function to display cheatsheets with bat
ch() {
  local cheatsheet_dir="cheatsheet"
  local cheatsheet_file="${cheatsheet_dir}/$1.md"
  
  if [ -f "$cheatsheet_file" ]; then
    glow -s "$HOME/.zsh/glow_tokyonight.json" -p "$cheatsheet_file"
  else
    echo "Cheatsheet for $1 not found."
  fi
}

