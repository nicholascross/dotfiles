#!/bin/zsh

git_path_dates() {
  if [ -z "$1" ]; then
    echo "Usage: git_path_dates <path>"
    return 1
  fi

  filepath="$1"
  first_commit_date=$(git log --reverse --format="%cd" --date=format:"%Y-%m-%d" -- "$filepath" | head -n 1)
  last_commit_date=$(git log -1 --format="%cd" --date=format:"%Y-%m-%d" -- "$filepath")

  echo -e "${filepath}\t${first_commit_date}\t${last_commit_date}"
}

git_path_stats() {
  if [ -z "$1" ]; then
    echo "Usage: git_path_dates <path>"
    return 1
  fi

  filepath="$1"
  first_commit_date=$(git log --reverse --format="%cd" --date=format:"%Y-%m-%d" -- "$filepath" | head -n 1)
  last_commit_date=$(git log -1 --format="%cd" --date=format:"%Y-%m-%d" -- "$filepath")
  commits_last_half_year=$(git log --since="6 month ago" --format="%cd" -- "$filepath" | wc -l)
  commits_last_year=$(git log --since="1 year ago" --format="%cd" -- "$filepath" | wc -l)
  commits_last_two_years=$(git log --since="2 year ago" --format="%cd" -- "$filepath" | wc -l)
  commits_last_five_years=$(git log --since="5 year ago" --format="%cd" -- "$filepath" | wc -l)
  commits_all=$(git log --format="%cd" -- "$filepath" | wc -l)

  echo -e "${filepath}\t${first_commit_date}\t${last_commit_date}\t${commits_last_half_year}\t${commits_last_year}\t${commits_last_two_years}\t${commits_last_five_years}\t${commits_all}"
}

git_path_stats_for_all_dirs() {
  # Check if a path is provided, if not, use the current directory
  if [ -z "$1" ]; then
    search_path="."
  else
    search_path="$1"
  fi

  # Find all directories in the specified path, excluding the .git directory
  find "$search_path" -maxdepth 1 -mindepth 1 -type d -not -path '*/.git*' | while read dir; do
    git_path_stats "$dir"
  done
}

# Search and preview files using fzf and ripgrep
function search_files() {
    rg --files-with-matches --no-messages "$1" | fzf --preview 'bat --style=numbers --color=always {} | head -500'
}

