return {
  bg = function()
    hl.exec_cmd("swaybg -i $(fd -e jpg -e jpeg -e png . $HOME/wallpapers | shuf -n1) -m fill")
  end,
  ssh = function()
    hl.exec_cmd("d4ssh.sh")
  end,
  clock = function()
    hl.exec_cmd("tmux new-session -d -s clock \\; clock-mode")
    hl.exec_cmd("[workspace special:clock silent] alacritty -e tmux new-session -As time")
  end,
  alacritty = function()
    hl.exec_cmd("alacritty -e tmux new-session -As home")
  end,
}
