# Function to display cheatsheets with bat
ch() {
  local cheatsheet_dir="$HOME/cheatsheet"
  local cheatsheet_file="${cheatsheet_dir}/$1.md"
  
  if [ -f "$cheatsheet_file" ]; then
    glow -s "$HOME/.zsh/glow_tokyonight.json" -p "$cheatsheet_file"
  else
    # If not found use fzf to search cheatsheet directory for md files
    local cheatsheet_file=$(fd . "$cheatsheet_dir" -e md | fzf)
    if [ -n "$cheatsheet_file" ]; then
      glow -s "$HOME/.zsh/glow_tokyonight.json" -p "$cheatsheet_file"
    fi
  fi
}

