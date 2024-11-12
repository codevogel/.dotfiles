#!/bin/bash
# deps: stow
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
stow -d $HOME/.dotfiles/ -t $HOME -S neovim
