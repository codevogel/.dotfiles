#!/bin/bash
# deps: stow
curl -LO https://github.com/neovim/neovim/releases/download/v0.11.1/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
stow -d $HOME/.dotfiles/ -t $HOME -S neovim
rm nvim-linux-x86_64.tar.gz
