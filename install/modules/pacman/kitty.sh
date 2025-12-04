# deps: stow
sudo pacman -S --noconfirm --needed kitty

rm -rf ~/.config/kitty
stow -d $HOME/.dotfiles/ -t $HOME -S kitty
