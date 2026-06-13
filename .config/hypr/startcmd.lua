return {
  bg = function()
    hl.exec_cmd("swaybg -i $(fd -e jpg -e jpeg -e png . $HOME/wallpapers | shuf -n1) -m fill")
  end,
  ssh = function()
    hl.exec_cmd("d4ssh.sh")
  end,
  clock = function()
    hl.exec_cmd("[workspace special:clock silent] alacritty -e tmux new-session -As clock \\; clock-mode")
  end,
  config = function()
    hl.exec_cmd("tmux new-session -d -s 'config' 'cd ~/.files && nvim .'")
  end,
  alacritty = function()
    hl.exec_cmd("alacritty -e tmux new-session -As home")
  end,
  obsidian = function()
    hl.exec_cmd("[workspace special:obsidian silent] alacritty -e tmux_obsidian.sh")
  end,
}
