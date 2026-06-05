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
    hl.exec_cmd("tmux new-session -d -s 'config'")
    hl.exec_cmd("tmux send-key -t 'config' l 'cd ~/.files' C-m")
    hl.exec_cmd("tmux send-key -t 'config' l 'vi' C-m")
  end,
  alacritty = function()
    hl.exec_cmd("alacritty -e tmux new-session -As home")
  end,
}
