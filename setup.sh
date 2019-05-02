#!/bin/bash

for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue

    echo "$f"
    ln -s $HOME/dotfiles/$f $HOME/$f
done

mkdir -p $HOME/.config/git/
ln -s $HOME/dotfiles/config/git/ignore $HOME/.config/git/ignore 
