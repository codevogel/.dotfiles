# Add brew install dir to path
export PATH=/home/linuxbrew/.linuxbrew/bin/:$PATH
# Add commitizen to path
export PATH=/home/codevogel/work/pls/release/:$PATH


alias wezterm='flatpak run org.wezfurlong.wezterm'
export EDITOR='nvim'

# Path to oh-my-zsh ( https://ohmyz.sh/ ) installation.
export ZSH=~/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
plugins=(git)

# Enable command auto-correction.
ENABLE_CORRECTION="true"

# Display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see oh-my-zsh #5765)
COMPLETION_WAITING_DOTS="true"

 # remind to update when it's time
zstyle ':omz:update' mode reminder

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(oh-my-posh init zsh --config ~/.poshthemes/patriksvensson.omp.json)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fpath=(~/.zshfuncs "${fpath[@]}")
autoload -Uz plz
