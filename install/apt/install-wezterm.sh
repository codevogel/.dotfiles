#!/bin/bash
# deps: stow
# add apt repo
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
# install
sudo apt install wezterm
sudo apt update
stow -d $HOME/.dotfiles/ -t $HOME -S wezterm
