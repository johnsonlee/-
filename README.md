## Overview

This repo is used to configure the `~` directory quickly on a new Mac by [bootstrap.sh](https://macosx.github.io/bootstrap.sh).

## Quick Start

```bash
cd ~

git init
git remote add origin https://github.com/macosx/home.git

git fetch --all && git checkout master
```

## Configure VIM

```bash
git submodule init && git submodule update

~/.vim/bundle/vim-powerline-fonts/install.sh
```
