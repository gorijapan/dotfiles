#!/bin/bash

## vim.dein https://github.com/Shougo/dein.vim
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
# For example, we just use `~/.cache/dein` as installation directory
mkdir -p ~/.cache
sh ./installer.sh ~/.cache/dein

## :call dein#install()
