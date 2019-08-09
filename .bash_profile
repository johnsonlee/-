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
alias proxy='export socks5_proxy=socks5://127.0.0.1:1086;export http_proxy=http://127.0.0.1:1087;export https_proxy=http://127.0.0.1:1087;'
alias unproxy='unset socks5_proxy http_proxy https_proxy'

if [ -x "$(command -v brew)" ]; then

    ## bash-completion

    [ "$(brew ls --versions bash-completion)" ] && [ -e "$(brew --prefix)/etc/bash_completion" ] && . $(brew --prefix)/etc/bash_completion

    ## nvm

    export NVM_DIR="$HOME/.nvm"
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
    [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"

    ## android sdk & ndk

    [ -d "$(brew --prefix)/share/android-sdk"    ] && export ANDROID_SDK_ROOT="$(brew --prefix)/share/android-sdk"
    [ -d "$(brew --prefix)/share/android-ndk"    ] && export ANDROID_NDK_HOME="$(brew --prefix)/share/android-ndk"

    ## icu4c

    [ -d "$(brew --prefix)/opt/icu4c/lib"        ] && export LDFLAGS="$LDFLAGS -L$(brew --prefix)/opt/icu4c/lib"
    [ -d "$(brew --prefix)/opt/icu4c/include"    ] && export CPPFLAGS="$CPPFLAGS -I$(brew --prefix)/opt/icu4c/include"
    [ ! -z "$(brew ls --versions icu4c)"         ] && export PATH="$(brew --prefix)/opt/icu4c/sbin:$PATH"

    ## readline

    [ -d "$(brew --prefix)/opt/readline/lib"     ] && export LDFLAGS="$LDFLAGS -L$(brew --prefix)/opt/readline/lib"
    [ -d "$(brew --prefix)/opt/readline/include" ] && export CPPFLAGS="$CPPFLAGS -I$(brew --prefix)/opt/readline/include"

    ## openssl

    [ -d "$(brew --prefix)/opt/openssl/lib"      ] && export LDFLAGS="$LDFLAGS -L$(brew --prefix)/opt/openssl/lib"
    [ -d "$(brew --prefix)/opt/openssl/include"  ] && export CPPFLAGS="$CPPFLAGS -I$(brew --prefix)/opt/openssl/include"
    [ ! -z "$(brew ls --versions openssl)"       ] && export PATH="$(brew --prefix)/opt/openssl/bin:$PATH"

    ## gpg-agent

    [ ! -z "$(brew ls --versions gpg-agent)"     ] && export PATH="$(brew --prefix)/opt/gpg-agent/bin:$PATH"

    ## coreutils

    [ ! -z "$(brew ls --versions coreutils)"     ] && export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

    ## groovy

    [ ! -z "$(brew ls --versions groovy)"        ] && export GROOVY_HOME="$(brew --prefix)/opt/groovy/libexec"

fi

## git command line promption

if [ ! -z "$(command -v __git_ps1)" ]; then
    export PROMPT_COMMAND='__git_ps1 "\\[$(tput bold)\\]\u@\h\\[$(tput sgr0)\\]:\\[$(tput setaf 4)\\]\w\\[$(tput sgr0)\\]" " \\\$ "'
fi

export PATH="~/bin:/usr/local/opt/python/libexec/bin:/usr/local/bin:/usr/local/sbin:$PATH"

