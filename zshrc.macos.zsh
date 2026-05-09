# File path: $HOME/.zshrc

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS

set_http_proxy() {
    local port="${1:-10808}"
    local host="${2:-127.0.0.1}"

    export http_proxy="http://$host:$port"
    export https_proxy="http://$host:$port"
    export all_proxy="http://$host:$port"

    echo "✅ Proxy set:"
    echo "   http_proxy=$http_proxy"
    echo "   https_proxy=$https_proxy"
    echo "   all_proxy=$all_proxy"
}

set_socks_proxy() {
    local port="${1:-1080}"
    local host="${2:-127.0.0.1}"

    export http_proxy="socks5h://$host:$port"
    export https_proxy="socks5h://$host:$port"
    export all_proxy="socks5h://$host:$port"

    echo "✅ Proxy set:"
    echo "   http_proxy=$http_proxy"
    echo "   https_proxy=$https_proxy"
    echo "   all_proxy=$all_proxy"
}

unset_proxy() {
    unset http_proxy
    unset https_proxy
    unset all_proxy

    echo "❎ Cleared proxy environment variables:"
    echo "   - http_proxy"
    echo "   - https_proxy"
    echo "   - all_proxy"
}


# ============================================================
# brew install starship
# ============================================================
eval "$(starship init zsh)"

# ============================================================
# brew install zsh-autosuggestions
# ============================================================
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# ============================================================
# brew install zsh-syntax-highlighting
# ============================================================
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# ============================================================
# brew install neovim
# ============================================================
export EDITOR=nvim
export VISUAL=nvim

# ============================================================
# brew install yazi
# ============================================================
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}

# ============================================================
# brew install zoxide
# ============================================================
eval "$(zoxide init zsh)"

# ============================================================
# brew install uv
# ============================================================
if [[ -f "$HOME/.local/bin/env" ]];then
    . "$HOME/.local/bin/env"
fi

# ============================================================
# npm install -g @fission-ai/openspec@latest
# ============================================================
# OPENSPEC:START
# OpenSpec shell completions configuration
fpath=("/Users/fly/.zsh/completions" $fpath)
autoload -Uz compinit
compinit
# OPENSPEC:END

# ============================================================
# brew install fzf
# ============================================================
source <(fzf --zsh)

# ============================================================
# brew install postgresql@18
# ============================================================
export PATH="/opt/homebrew/opt/postgresql@18/bin:$PATH"

# ============================================================
# brew install openjdk
# ============================================================
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# ============================================================
# brew install nvm
# ============================================================
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
