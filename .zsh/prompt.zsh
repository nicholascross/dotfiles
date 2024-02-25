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

cmd_start_time=0

preexec_rprompt() {
    cmd_start_time=$(date +%s)
}

precmd_rprompt() {
    cmd_exit_status=$?
    if [[ $cmd_start_time -ne 0 ]]; then
        cmd_end_time=$(date +%s)
        cmd_duration=$((cmd_end_time - cmd_start_time))

        if [[ $cmd_exit_status -eq 0 ]]; then
            status_icon="%F{34}%f%K{34}%F{22}✔ %f%k"
            RPROMPT="${status_icon}%K{34}%F{22}  ${cmd_duration}s %f%k"
        else
            status_icon="%F{214}%f%K{214}%F{red}✖ $cmd_exit_status %f%k"
            RPROMPT="${status_icon}%K{214}%F{red}  ${cmd_duration}s %f%k"
        fi
    else
        RPROMPT=""
    fi
}

add-zsh-hook preexec preexec_rprompt
add-zsh-hook precmd precmd_rprompt

