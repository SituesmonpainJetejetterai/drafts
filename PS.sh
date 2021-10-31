#!/usr/bin/env sh

# _BLACK=$(tput setaf 0)
# _RED=$(tput setaf 1)
# _GREEN=$(tput setaf 2)
# _YELLOW=$(tput setaf 3)
# _BLUE=$(tput setaf 4)
# _MAGENTA=$(tput setaf 5)
# _CYAN=$(tput setaf 6)
# _WHITE=$(tput setaf 7)
# _RESET=$(tput sgr0)
# _BOLD=$(tput bold)

# export PS1="${_WHITE}\u@${_GREEN}\h${}"
# export PS1="\[$(tput bold)$(tput setb 4)$(tput setaf 7)\]\u@\h:\w $ \[$(tput sgr0)\]"

git_branch() {
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null | sed -e 's/* \(.*\)/(\1)/')
    git pull origin "${branch}"
    printf "%s" "${branch}"
}

export PS1="\[$(tput setab 0)$(tput setaf 3)$(tput bold)\]\u\[$(tput setb 0)$(tput setaf 7)\]@\[$(tput setb 2)$(tput setaf 6)\]\h \[$(tput setab 0)$(tput setaf 1)\]->\[$(tput setb 7)$(tput setaf 0)\] \w \[$(tput setaf 1)\][$(git_branch)]\n\[$(tput bold)$(tput setaf 4)\]\_$ \[$(tput sgr0)\]"
