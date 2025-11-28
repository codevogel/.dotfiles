#deps: curl zsh
if [[ -d "$HOME/.oh-my-zsh" ]]; then
	echo "🐦 | ⚠️ Oh My Zsh directory already exists, overwriting..."
	rm -rf "$HOME/.oh-my-zsh"
	return 0
fi

# Install assuming we already have oh my zsh config in ~/.zshrc
export KEEP_ZSHRC="yes"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
