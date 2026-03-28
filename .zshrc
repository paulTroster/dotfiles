export PATH="$HOME/.pyenv/bin:$PATH"
. "$HOME/.local/bin/env"
source "$HOME/.dotfiles/aliases.zsh"

eval "$(pyenv init -)"
eval "$(zoxide init zsh)"

# source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh

eval "$(starship init zsh)"
