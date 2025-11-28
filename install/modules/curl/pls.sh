# deps: curl stow yq fzf
mkdir -p ~/work/pls
curl -sS https://raw.githubusercontent.com/codevogel/pls/main/release/pls >~/work/pls/pls && chmod +x ~/work/pls/pls
stow -d $HOME/.dotfiles/ -t $HOME -S pls
