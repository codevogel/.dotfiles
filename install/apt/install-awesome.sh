#!/bin/bash
sudo apt-get install awesome -y
stow -d $HOME/.dotfiles/ -t $HOME -S awesome
