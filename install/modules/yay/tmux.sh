# deps: yay stow git
yay -S --noconfirm --needed tmux

# check if TPM is installed
if [ -d ~/.tmux/plugins/tpm ]; then
	# offer to remove it
	echo "🐦 | ⚠️ TPM was already installed. Overwriting installation."
	rm -rf ~/.tmux/plugins/tpm
fi

# install TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

stow -d $HOME/.dotfiles/ -t $HOME -S tmux
