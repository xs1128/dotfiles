# Setting PATH for Python 3.12
# The original version is saved in .zprofile.pysave
export PATH="/Library/Frameworks/Python.framework/Versions/3.12/bin:$PATH"

eval "$(/opt/homebrew/bin/brew shellenv)"

# Add Visual Studio Code (code)
export PATH="$PATH:$HOME/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Source zsh autosuggestions if installed
[[ -f $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Initialize rbenv (manage Ruby versions)
# Added by `rbenv init` on Sat Apr 26 17:01:36 CST 2025
eval "$(rbenv init - --no-rehash zsh)"

# Helper to add directories to PATH if not already present
path_add() {
  case ":$PATH:" in
    *":$1:"*) ;;
    *) export PATH="$1:$PATH" ;;
  esac
}

# Use it to add paths
path_add "/opt/homebrew/opt/llvm/bin"
path_add "$HOME/.local/bin"
path_add "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# Source aliases if file exists
[[ -f $HOME/.aliases ]] && source $HOME/.aliases
#
# Source autojump orbstack scripts safely
[[ -f /opt/homebrew/etc/profile.d/autojump.sh ]] && source /opt/homebrew/etc/profile.d/autojump.sh
[[ -f $HOME/.orbstack/shell/init.zsh ]] && source $HOME/.orbstack/shell/init.zsh
