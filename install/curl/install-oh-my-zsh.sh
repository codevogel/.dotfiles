#!/bin/bash
# deps: zsh

# Export env variable so the oh-my-zsh install script does not override our .zshrc 
export KEEP_ZSHRC='yes'
# Install oh-my-zsh (unattended: does not open zsh afterwards, and does not change default shell)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
