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

