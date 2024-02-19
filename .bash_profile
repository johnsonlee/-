#!/bin/bash

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_HIDE_IF_PWD_IGNORED=true
export GIT_PS1_SHOWCOLORHINTS=true

## Alias

alias ls='ls -G'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'

## nvm

[ -d "$HOME/.nvm" ] && export NVM_DIR="$HOME/.nvm"

## Homebrew formulas

eval "$(/opt/homebrew/bin/brew shellenv)"

if [ -x "$(command -v brew)" ]; then

    BREW_PREFIX=$(brew --prefix)

    ## bash-completion

    [ -e "${BREW_PREFIX}/etc/bash_completion"          ] && . ${BREW_PREFIX}/etc/bash_completion

    ## android sdk & ndk

    [ -d "${BREW_PREFIX}/share/android-sdk"            ] && export ANDROID_SDK_ROOT="${BREW_PREFIX}/share/android-sdk"
    [ -d "${BREW_PREFIX}/share/android-ndk"            ] && export ANDROID_NDK_HOME="${BREW_PREFIX}/share/android-ndk"

    ## icu4c

    [ -d "${BREW_PREFIX}/opt/icu4c/lib"                ] && export LDFLAGS="$LDFLAGS -L${BREW_PREFIX}/opt/icu4c/lib"
    [ -d "${BREW_PREFIX}/opt/icu4c/include"            ] && export CPPFLAGS="$CPPFLAGS -I${BREW_PREFIX}/opt/icu4c/include"
    [ -d "${BREW_PREFIX}/opt/icu4c/sbin"               ] && export PATH="${BREW_PREFIX}/opt/icu4c/sbin:$PATH"

    ## readline

    [ -d "${BREW_PREFIX}/opt/readline/lib"             ] && export LDFLAGS="$LDFLAGS -L${BREW_PREFIX}/opt/readline/lib"
    [ -d "${BREW_PREFIX}/opt/readline/include"         ] && export CPPFLAGS="$CPPFLAGS -I${BREW_PREFIX}/opt/readline/include"

    ## openssl

    [ -d "${BREW_PREFIX}/opt/openssl/lib"              ] && export LDFLAGS="$LDFLAGS -L${BREW_PREFIX}/opt/openssl/lib"
    [ -d "${BREW_PREFIX}/opt/openssl/include"          ] && export CPPFLAGS="$CPPFLAGS -I${BREW_PREFIX}/opt/openssl/include"
    [ -d "${BREW_PREFIX}/opt/openssl/bin"              ] && export PATH="${BREW_PREFIX}/opt/openssl/bin:$PATH"

    ## gpg-agent

    [ -d "${BREW_PREFIX}/opt/gpg-agent/bin"            ] && export PATH="${BREW_PREFIX}/opt/gpg-agent/bin:$PATH"

    ## coreutils

    [ -d "${BREW_PREFIX}/opt/coreutils/libexec/gnubin" ] && export PATH="${BREW_PREFIX}/opt/coreutils/libexec/gnubin:$PATH"

    ## groovy

    [ -d "${BREW_PREFIX}/opt/groovy/libexec"           ] && export GROOVY_HOME="${BREW_PREFIX}/opt/groovy/libexec"

    ## gnu command line

    [ -d "${BREW_PREFIX}/opt/python/libexec/bin"       ] && export PATH="${BREW_PREFIX}/opt/python/libexec/bin:$PATH"
    [ -d "${BREW_PREFIX}/opt/gawk/libexec/gnubin"      ] && export PATH="${BREW_PREFIX}/opt/gawk/libexec/gnubin:$PATH"
    [ -d "${BREW_PREFIX}/opt/gnu-sed/libexec/gnubin"   ] && export PATH="${BREW_PREFIX}/opt/gnu-sed/libexec/gnubin:$PATH"
    [ -d "${BREW_PREFIX}/opt/grep/libexec/gnubin"      ] && export PATH="${BREW_PREFIX}/opt/grep/libexec/gnubin:$PATH"
    [ -d "${BREW_PREFIX}/opt/binutils/bin"             ] && export PATH="${BREW_PREFIX}/opt/binutils/bin:$PATH"

    ## nvm

    [ -s "${BREW_PREFIX}/opt/nvm/nvm.sh"               ] && . "${BREW_PREFIX}/opt/nvm/nvm.sh"
    [ -s "${BREW_PREFIX}/opt/nvm/etc/bash_completion"  ] && . "${BREW_PREFIX}/opt/nvm/etc/bash_completion"

    ## bash-git-prompt
    if [ -f "${BREW_PREFIX}/opt/bash-git-prompt/share/gitprompt.sh" ]; then
        __GIT_PROMPT_DIR="${BREW_PREFIX}/opt/bash-git-prompt/share"
        source "${BREW_PREFIX}/opt/bash-git-prompt/share/gitprompt.sh"
    fi
fi

## git command line promption

[ ! -z "$(command -v __git_ps1)" ] && export PROMPT_COMMAND='__git_ps1 "\\[$(tput bold)\\]\u@\h\\[$(tput sgr0)\\]:\\[$(tput setaf 4)\\]\w\\[$(tput sgr0)\\]" " \\\$ "'

## user bins

[ -d "$HOME/bin" ] && export PATH="~/bin:/usr/local/bin:/usr/local/sbin:$PATH"

