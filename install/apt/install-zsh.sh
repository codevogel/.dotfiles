#!/bin/bash
# DEPS: stow
sudo apt-get install zsh -y
# Stow the zsh package at the home directory
stow -d ~/.dotfiles -t ~ -S zsh
