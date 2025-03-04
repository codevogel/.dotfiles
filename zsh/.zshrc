# Add brew install dir to path
export PATH=/home/linuxbrew/.linuxbrew/bin/:$PATH
# Add commitizen to path
export PATH=/home/codevogel/work/pls/release/:$PATH
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export PATH="$PATH:/home/codevogel/.local/bin"

export PATH="$PATH:/.local/bin"
export PATH="$PATH:/home/codevogel/.local/share/nvim/mason/bin"
export EDITOR='nvim'
export PATH="$PATH:/home/codevogel/pyvenv/bin"

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

# pnpm
export PNPM_HOME="/home/codevogel/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Start ue4cli wrapper
# Expand ue4cli
ue() {
	ue4cli=$HOME/.local/bin/ue4
	engine_path=$($ue4cli root)

  # cd to ue location
	if [[ "$1" == "engine" ]]; then
		cd $engine_path
  # combine clean and build in one command
	elif [[ "$1" == "rebuild" ]]; then
		$ue4cli clean
		$ue4cli build 
		if [[ "$2" == "run" ]]; then
			$ue4cli run
		fi
  # build and optionally run while respecting build flags
	elif [[ "$1" == "build" ]]; then
		if [[ "${@: -1}" == "run" ]]; then
			length="$(($# - 2))" # Get length without last param because of 'run'
			$ue4cli build ${@:2:$length}
			$ue4cli run
		else
			shift 1
			$ue4cli build "$@"
		fi
  # Run project files generation, create a symlink for the compile database and fix-up the compile database
	elif [[ "$1" == "gen" ]]; then
		$ue4cli gen
		project=${PWD##*/}
		cat ".vscode/compileCommands_${project}.json" | python -c 'import json,sys
j = json.load(sys.stdin)
for o in j:
  file = o["file"]
  arg = o["arguments"][1]
  o["arguments"] = ["clang++ -std=c++20 -ferror-limit=0 -Wall -Wextra -Wpedantic -Wshadow-all -Wno-unused-parameter " + file + " " + arg]
print(json.dumps(j, indent=2))' > compile_commands.json
  # Pass through all other commands to ue4
	else
		$ue4cli "$@"
	fi
}

alias ue4='echo Please use ue instead.'
alias ue5='echo Please use ue instead.'
# End ue4cli wrapper
