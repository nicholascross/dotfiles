autoload -U add-zsh-hook

git_prompt_info() {
  branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [ -n "$branch" ]; then
    # Set both foreground (text) and background colors
    echo "%K{129}%F{201}  ($branch)%f%k%F{129}%f"
  else
    echo "%F{110}%f"
  fi
}

set_prompt() {
  PROMPT="%K{110}%F{black} 󰉖 %f%F{60}%(5~|%-1~/…/%3~|%4~) %f%k$(git_prompt_info) "
}

set_prompt

minimise_prompt() {
  PROMPT="%K{34} %F{22}%D{%L:%M:%S}%f%k%F{34}%f "
  zle reset-prompt
  set_prompt
  zle accept-line
}

add-zsh-hook chpwd set_prompt

zle -N minimise_prompt
bindkey "^M" minimise_prompt
