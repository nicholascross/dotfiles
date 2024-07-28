COLOR_BG_PRIMARY="#1f2335"
COLOR_BG_SECONDARY="#24283b"
COLOR_BG_TERTIARY="#292e42"
COLOR_BG_QUATERNARY="#3b4261"
COLOR_BG_QUINARY="#414868"
COLOR_FG_LIGHT_GRAY="#545c7e"
COLOR_BG_GIT="#565f89"
COLOR_FG_GIT_ARROW="#737aa2"
COLOR_FG_PATH_ALT="#a9b1d6"
COLOR_FG_PATH_ALT_LIGHT="#c0caf5"
COLOR_BG_PATH_ALT_LIGHT="#394b70"
COLOR_FG_PATH="#3d59a1"
COLOR_BG_GIT_ALT="#7aa2f7"
COLOR_FG_GIT_BRANCH="#7dcfff"
COLOR_BG_GIT_BRANCH_ALT="#b4f9f8"
COLOR_FG_GIT_BRANCH_LIGHT="#bb9af7"
COLOR_BG_GIT_BRANCH_LIGHT="#9d7cd8"
COLOR_FG_WARNING="#ff9e64"
COLOR_FG_WARNING_LIGHT="#ffc777"
COLOR_FG_SUCCESS_ICON="#41a6b5"
COLOR_BG_SUCCESS="#4fd6be"
COLOR_FG_ERROR_ICON="#c53b53"
COLOR_BG_ERROR="#ff9e64"
COLOR_FG_ERROR_LIGHT="#ff007c"

git_prompt_info() {
  branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [ -n "$branch" ]; then
    # Set both foreground (text) and background colors
    echo "%K{$COLOR_BG_GIT}%F{$COLOR_FG_GIT_BRANCH_LIGHT}  ($branch)%f%k%F{$COLOR_BG_GIT}%f"
  else
    echo "%F{$COLOR_FG_GIT_ARROW}%f"
  fi
}

set_prompt() {
  PROMPT="%K{$COLOR_BG_GIT_ALT}%F{$COLOR_BG_PRIMARY} 󰉖 %f%F{$COLOR_BG_QUATERNARY}%(5~|%-1~/…/%3~|%4~) %f%k$(git_prompt_info) "
}

set_prompt

minimise_prompt() {
  PROMPT="%K{$COLOR_BG_QUATERNARY} %F{$COLOR_FG_SUCCESS_ICON}%D{%L:%M:%S}%f%k%F{$COLOR_BG_QUATERNARY}%f "
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
            status_icon="%F{$COLOR_BG_SUCCESS}%f%K{$COLOR_BG_SUCCESS}%F{$COLOR_FG_SUCCESS_ICON}✔ %f%k"
            RPROMPT="${status_icon}%K{$COLOR_BG_SUCCESS}%F{$COLOR_FG_SUCCESS_ICON}  ${cmd_duration}s %f%k%F{$COLOR_BG_SUCCESS}%f%K{$COLOR_BG_SUCCESS}"
        else
            status_icon="%F{$COLOR_BG_ERROR}%f%K{$COLOR_BG_ERROR}%F{$COLOR_FG_ERROR_ICON}✖ $cmd_exit_status %f%k"
            RPROMPT="${status_icon}%K{$COLOR_BG_ERROR}%F{$COLOR_FG_ERROR_ICON}  ${cmd_duration}s %f%k%F{$COLOR_BG_ERROR}%f%K{$COLOR_BG_ERROR}"
        fi
    else
        RPROMPT=""
    fi

    cmd_start_time=0
}

add-zsh-hook preexec preexec_rprompt
add-zsh-hook precmd precmd_rprompt

