#!/bin/bash

# check git

if [ ! -x "$(which git)" ]; then
    echo "git command not found"
    exit -1
fi

# install and configure ~

[ ! -d "$HOME/.git" ] && cd $HOME \
    && git init \
    && git remote add origin git@github.com:johnsonlee/-.git \
    && git fetch --all \
    && git checkout main \
    && git submodule init \
    && git submodule update \
    && $HOME/.vim/bundle/vim-powerline-fonts/install.sh


## Install HomeBrew

if [ ! -x "$(command -v brew)" ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

## Install GNU packages

GNU_PACKAGES="gawk grep gnu-sed"

for pkg in $GNU_PACKAGES; do
    if [ ! "$(brew ls --versions $pkg)" ]; then
        brew install -v $pkg
    fi
done


## Install core packages

TERM_PACKAGES="$TERM_PACKAGES aria2"
TERM_PACKAGES="$TERM_PACKAGES bash-completion"
TERM_PACKAGES="$TERM_PACKAGES carthage"
TERM_PACKAGES="$TERM_PACKAGES cocoapods"
TERM_PACKAGES="$TERM_PACKAGES coreutils"
TERM_PACKAGES="$TERM_PACKAGES ffmpeg"
TERM_PACKAGES="$TERM_PACKAGES git"
TERM_PACKAGES="$TERM_PACKAGES gpg"
TERM_PACKAGES="$TERM_PACKAGES gpg-agent"
TERM_PACKAGES="$TERM_PACKAGES html-xml-utils"
TERM_PACKAGES="$TERM_PACKAGES htop"
TERM_PACKAGES="$TERM_PACKAGES iftop"
TERM_PACKAGES="$TERM_PACKAGES jq"
TERM_PACKAGES="$TERM_PACKAGES p7zip"
TERM_PACKAGES="$TERM_PACKAGES pngquant"
TERM_PACKAGES="$TERM_PACKAGES terminal-notifier"
TERM_PACKAGES="$TERM_PACKAGES tmux"
TERM_PACKAGES="$TERM_PACKAGES tree"
TERM_PACKAGES="$TERM_PACKAGES webp"
TERM_PACKAGES="$TERM_PACKAGES wget"

for pkg in $TERM_PACKAGES; do
    if [ ! "$(brew ls --versions $pkg)" ]; then
        brew install -v $pkg
    fi
done


## Install java packages

if [ ! "$(brew ls --versions openjdk@11)" ]; then
    brew install -v openjdk@11
    sudo ln -sfn /usr/local/opt/openjdk@11/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-11.jdk
fi

JAVA_PACKAGES="$JAVA_PACKAGES antlr"
JAVA_PACKAGES="$JAVA_PACKAGES antlr"
JAVA_PACKAGES="$JAVA_PACKAGES aspectj"
JAVA_PACKAGES="$JAVA_PACKAGES cfr-decompiler"
JAVA_PACKAGES="$JAVA_PACKAGES gradle"
JAVA_PACKAGES="$JAVA_PACKAGES groovy"
JAVA_PACKAGES="$JAVA_PACKAGES maven"
JAVA_PACKAGES="$JAVA_PACKAGES apktool"
JAVA_PACKAGES="$JAVA_PACKAGES dex2jar"
JAVA_PACKAGES="$JAVA_PACKAGES jadx"
JAVA_PACKAGES="$JAVA_PACKAGES smali"

for pkg in $JAVA_PACKAGES; do
    if [ ! "$(brew ls --versions $pkg)" ]; then
        brew install -v $pkg
    fi
done


## Install nvm

if [ ! "$(brew ls --cask --versions nvm)" ]; then
    brew install --cask -v nvm && mkdir ~/.nvm           
fi


## Install cask packages

CASK_PACKAGES="$CASK_PACKAGES android-file-transfer"
CASK_PACKAGES="$CASK_PACKAGES android-ndk"
CASK_PACKAGES="$CASK_PACKAGES android-platform-tools"
CASK_PACKAGES="$CASK_PACKAGES android-sdk"
CASK_PACKAGES="$CASK_PACKAGES android-studio"
CASK_PACKAGES="$CASK_PACKAGES aria2gui"
CASK_PACKAGES="$CASK_PACKAGES charles"
CASK_PACKAGES="$CASK_PACKAGES docker"
CASK_PACKAGES="$CASK_PACKAGES balenaetcher"
CASK_PACKAGES="$CASK_PACKAGES google-chrome"
CASK_PACKAGES="$CASK_PACKAGES iina"
CASK_PACKAGES="$CASK_PACKAGES intellij-idea-ce"
CASK_PACKAGES="$CASK_PACKAGES iterm2"
CASK_PACKAGES="$CASK_PACKAGES sketch"
CASK_PACKAGES="$CASK_PACKAGES stats"
CASK_PACKAGES="$CASK_PACKAGES sublime-text"
CASK_PACKAGES="$CASK_PACKAGES typora"
CASK_PACKAGES="$CASK_PACKAGES vagrant"
CASK_PACKAGES="$CASK_PACKAGES virtualbox"
CASK_PACKAGES="$CASK_PACKAGES visual-studio-code"
CASK_PACKAGES="$CASK_PACKAGES visualvm"
CASK_PACKAGES="$CASK_PACKAGES wechat"
CASK_PACKAGES="$CASK_PACKAGES xmind-zen"

for pkg in $CASK_PACKAGES; do
    if [ ! "$(brew ls --cask --versions $pkg)" ]; then
        brew install --cask -v $pkg
    fi
done

brew cleanup --prune=all && rm -rf /Library/Caches/Homebrew/*
