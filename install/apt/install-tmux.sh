#!/bin/bash
# deps: stow, git, libevent-dev, ncurses-dev, build-essential, bison, pkg-config

sudo rm -rf /usr/local/bin/tmux
wget https://github.com/tmux/tmux/releases/download/3.5a/tmux-3.5a.tar.gz
tar -xzf tmux-3.5a.tar.gz
cd tmux-3.5a
./configure && make
sudo make install
# cleanup
cd ..
rm -rf tmux-3.5a
rm tmux-3.5a.tar.gz

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
