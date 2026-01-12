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
eval $(keychain --eval --quiet D4rkn1)
export PATH="$HOME/.local/bin:$HOME/bash:$HOME/appimage:$HOME/bash:/usr/local/sbin:/usr/local/bin:/usr/bin:/var/lib/flatpak/exports/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/usr/lib/rustup/bin:$PATH"
