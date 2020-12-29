#!/bin/bash

## homebrew https://brew.sh/index_ja
echo "install homebrew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install git tig tmux zsh zsh-completions peco the_silver_searcher jq node cowsay gawk nkf tree p7zip unrar optipng awscli aws-elasticbeanstalk go ghq
