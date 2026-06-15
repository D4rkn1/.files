export PATH="$PATH:$HOME/bash"
export PATH="$PATH:$HOME/python"
export nvimd="$HOME/.config/nvim"
export gitemail="73800712+D4rkn1@users.noreply.github.com"
export HOSTNAME=$(uname -n)
source ~/.keychain/$HOSTNAME-sh
export PATH="$HOME/.local/bin:$HOME/bash:$HOME/appimage:$HOME/bash:/usr/local/sbin:/usr/local/bin:/usr/bin:/var/lib/flatpak/exports/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/usr/lib/rustup/bin:$PATH"

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
