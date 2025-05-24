#!/bin/bash

# check git

if [ ! -x "$(which git)" ]; then
    echo "git command not found"
    exit -1
fi

# install and configure ~

[ ! -d "$HOME/.git" ] && cd $HOME \
    && git init \
    && git remote add origin https://github.com/johnsonlee/-.git \
    && git fetch --all \
    && git checkout main \
    && git submodule init \
    && git submodule update \
    && $HOME/.vim/bundle/vim-powerline-fonts/install.sh


## Install HomeBrew

if [ ! -x "$(command -v brew)" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi


## Install Formulas

FORMULAS="$FORMULAS gawk"
FORMULAS="$FORMULAS grep"
FORMULAS="$FORMULAS gnu-sed"
FORMULAS="$FORMULAS aria2"
FORMULAS="$FORMULAS binutils"
FORMULAS="$FORMULAS bash-completion"
FORMULAS="$FORMULAS bash-git-prompt"
FORMULAS="$FORMULAS carthage"
FORMULAS="$FORMULAS cocoapods"
FORMULAS="$FORMULAS coreutils"
FORMULAS="$FORMULAS delta"
FORMULAS="$FORMULAS ffmpeg"
FORMULAS="$FORMULAS git"
FORMULAS="$FORMULAS gpg"
FORMULAS="$FORMULAS graphviz"
FORMULAS="$FORMULAS html-xml-utils"
FORMULAS="$FORMULAS htop"
FORMULAS="$FORMULAS iftop"
FORMULAS="$FORMULAS jq"
FORMULAS="$FORMULAS nvm"
FORMULAS="$FORMULAS openjdk@17"
FORMULAS="$FORMULAS p7zip"
FORMULAS="$FORMULAS pngquant"
FORMULAS="$FORMULAS python-setuptools"
FORMULAS="$FORMULAS scrcpy"
FORMULAS="$FORMULAS terminal-notifier"
FORMULAS="$FORMULAS tmux"
FORMULAS="$FORMULAS tree"
FORMULAS="$FORMULAS webp"
FORMULAS="$FORMULAS wget"

FORMULAS="$FORMULAS antlr"
FORMULAS="$FORMULAS antlr"
FORMULAS="$FORMULAS apktool"
FORMULAS="$FORMULAS aspectj"
FORMULAS="$FORMULAS cfr-decompiler"
FORMULAS="$FORMULAS dex2jar"
FORMULAS="$FORMULAS gradle"
FORMULAS="$FORMULAS groovy"
FORMULAS="$FORMULAS jadx"
FORMULAS="$FORMULAS maven"
FORMULAS="$FORMULAS smali"

for pkg in $FORMULAS; do
    [ ! "$(brew list --versions $pkg)" ] && brew install -v $pkg
    [ "$pkg" == "openjdk@17" ] && sudo ln -sfn $(brew --prefix openjdk@17)/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-17.jdk
done


## Install Casks

CASK_PACKAGES="$CASK_PACKAGES android-file-transfer"
CASK_PACKAGES="$CASK_PACKAGES android-platform-tools"
CASK_PACKAGES="$CASK_PACKAGES android-studio"
CASK_PACKAGES="$CASK_PACKAGES aria2gui"
CASK_PACKAGES="$CASK_PACKAGES balenaetcher"
CASK_PACKAGES="$CASK_PACKAGES charles"
CASK_PACKAGES="$CASK_PACKAGES docker"
CASK_PACKAGES="$CASK_PACKAGES google-chrome"
CASK_PACKAGES="$CASK_PACKAGES graalvm-jdk@17"
CASK_PACKAGES="$CASK_PACKAGES iina"
CASK_PACKAGES="$CASK_PACKAGES intellij-idea-ce"
CASK_PACKAGES="$CASK_PACKAGES iterm2"
CASK_PACKAGES="$CASK_PACKAGES pycharm-ce"
CASK_PACKAGES="$CASK_PACKAGES stats"
CASK_PACKAGES="$CASK_PACKAGES sublime-text"
CASK_PACKAGES="$CASK_PACKAGES typora"
CASK_PACKAGES="$CASK_PACKAGES visual-studio-code"
CASK_PACKAGES="$CASK_PACKAGES visualvm"
CASK_PACKAGES="$CASK_PACKAGES wechat"
CASK_PACKAGES="$CASK_PACKAGES xmind-zen"

for pkg in $CASK_PACKAGES; do
    [ ! "$(brew list --cask --versions $pkg)" ] && brew install --cask -v $pkg
done

brew cleanup --prune=all && rm -rf /Library/Caches/Homebrew/*
