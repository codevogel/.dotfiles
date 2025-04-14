#!/bin/bash
# deps: stow
sudo apt-get install awesome -y
stow -d $HOME/.dotfiles/ -t $HOME -S awesome
