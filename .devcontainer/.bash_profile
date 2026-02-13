function parse_git_branch {
  local repo_root
  repo_root=$(git rev-parse --show-toplevel 2>/dev/null)
  if [ "$repo_root" = "$HOME" ]; then
    return
  fi
  git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="[\[\e[37;44m\]\t\[\e[0m\]] \[\e[92m\]\w\[\033[31m\]\$(parse_git_branch)\[\033[00m\]\n$ "

TZ='America/New_York'; export TZ
