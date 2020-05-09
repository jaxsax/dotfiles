autoload -U compinit && compinit
autoload -Uz zcalc

source "$HOME/.zplugins/zsh-z.plugin.zsh"
zstyle ':completion:*' menu select

PROMPT='%F{208}%n%f in %F{226}%~%f -> '

# colors in tmux
[[ $TMUX != "" ]] && export TERM="xterm-256color"

# line movement
bindkey  "\e^A" beginning-of-line
bindkey  "\e^E" end-of-line

# ctrl-left/right
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word

# alt-left/right
bindkey "\e[1;3C" forward-word
bindkey "\e[1;3D" backward-word

# ctrl-backspace/delete
bindkey "\C-_" backward-kill-word
bindkey "\e[3;5~" kill-word

# History
HISTFILE=~/.zhistory
HISTSIZE=10000000
SAVEHIST=10000000
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS

path=(
    "$HOME/bin"
    "$HOME/.local/bin"
    "$HOME/go/bin"
    "$HOME/.yarn/bin"
    $path)

export PATH
