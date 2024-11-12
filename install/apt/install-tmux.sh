#!/bin/bash
# deps: stow, git
sudo apt-get install tmux -y
stow -d $HOME/.dotfiles/ -t $HOME -S tmux

# check if TPM is installed
if [ -d ~/.tmux/plugins/tpm ]; then
  # offer to remove it
  read -p "❗ TPM is already installed. Do you want to remove it? (y/n) " response
  if [[ $response =~ ^[Yy]$ ]]; then
    rm -rf ~/.tmux/plugins/tpm
  else
    echo "🗨️ TPM is already installed. Skipping installaton."
    exit 0
  fi
fi

# install TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo 'ℹ️ TMUX is installed, but do not forget to install the tmux plugins! To do this, run tmux and press <leader> + I'
