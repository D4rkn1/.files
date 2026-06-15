#zmodload zsh/zprof
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
unsetopt beep
bindkey -v

bindkey -a 'm' vi-backward-char
bindkey -a 'n' vi-down-line-or-history
bindkey -a 'e' vi-up-line-or-history
bindkey -a 'i' vi-forward-char

bindkey -a 'l' vi-insert
bindkey -a 'I' vi-insert-bol
bindkey -a 'h' vi-forward-word-end

function zle-line-init() { zle vi-cmd-mode }
zle -N zle-line-init

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
autoload -Uz compinit promptinit
compinit
promptinit
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
alias ls="ls -a --color=auto"
alias cp="rsync -av --progress"
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias viu='nvim --listen /tmp/nvim-unity.pipe'
alias vi='nvim .'
alias mpv='mpv --speed=1.75 --osc=no --osd-level=0 --sub-visibility=no'
alias cwd="pwd | tr -d '\n' | wl-copy"
alias trn="transmission-remote"
alias ls="lsd --blocks=size,name -A"
alias spek="$HOME/repo/spek/src/spek"
alias sonic="$HOME/repo/sonic-visualiser/build/sonic-visualiser"
export nvimd="$HOME/.config/nvim"
export gitemail="73800712+D4rkn1@users.noreply.github.com"
export HOSTNAME=$(uname -n)
source ~/.keychain/$HOSTNAME-sh
export PATH="$HOME/.local/bin:$HOME/bash:$HOME/appimage:$HOME/bash:/usr/local/sbin:/usr/local/bin:/usr/bin:/var/lib/flatpak/exports/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/usr/lib/rustup/bin:$PATH"

fcd() {
    local dir
    dir=$(fd -H -td . "$HOME" | fzf --scheme=path --smart-case)
    [[ -n "$dir" ]] && cd "$dir"
    zle accept-line
}
zle -N fcd
bindkey -M vicmd '^[s' fcd

export NVM_DIR="$HOME/.nvm"
nvm() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
  nvm "$@"
}
node() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
  node "$@"
}
npm() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
  npm "$@"
}
npx() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
  npx "$@"
}

keys=(${HOME}/.ssh/*(N-.))

keys=(${keys:#*.pub})
keys=(${keys:#${HOME}/.ssh/config})
keys=(${keys:#${HOME}/.ssh/known_hosts*})
keys=(${keys:#${HOME}/.ssh/authorized_keys*})
keys=(${keys:#${HOME}/.ssh/agent*})

keys=(${keys:t})

(( ${#keys} )) && eval "$(keychain --eval --quiet $keys)"
#zprof
