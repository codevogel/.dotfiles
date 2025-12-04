#deps: stow
yay -S --noconfirm --needed zsh
rm -rf ~/.zshrc ~/.zprofile ~/.zshfuncs
stow -d $HOME/.dotfiles/ -t $HOME -S zsh
