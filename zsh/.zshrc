# zsh-newuser-install start
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch
bindkey -v
# zsh-newuser-install end

# compinstall start
zstyle :compinstall filename '/home/codevogel/.zshrc'

autoload -Uz compinit
compinit
# compinstall end

# NVM start
source /usr/share/nvm/init-nvm.sh
# NVM end

# Oh My Zsh start
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)

source $ZSH/oh-my-zsh.sh
# Oh My Zsh end

# Pyenv start
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"
#Pyenv end

#pls start
export PATH=$HOME/work/pls/:$PATH
#pls end

#nvm start
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#nvm end

#dotnet start
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools
#dotnet end

# Oh My Posh
export PATH=$PATH:/home/codevogel/.local/bin
eval "$(oh-my-posh init zsh --config $HOME/.poshthemes/patriksvensson.omp.json)"
# Oh My Posh end
