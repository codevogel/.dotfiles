# deps: yay stow
yay -S --noconfirm --needed neovim

stow -d $HOME/.dotfiles/ -t $HOME -S neovim
