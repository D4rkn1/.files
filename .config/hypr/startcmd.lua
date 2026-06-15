return {
  bg = function()
    hl.exec_cmd("swaybg -i $(fd -e jpg -e jpeg -e png . $HOME/wallpapers | shuf -n1) -m fill")
  end,
  ssh = function()
    hl.exec_cmd("d4ssh.sh")
  end,
  clock = function()
    hl.exec_cmd(
      " alacritty -e tmux new-session -As clock \\; clock-mode",
      { workspace = "special:clock silent", fullscreen = true }
    )
  end,
  config = function()
    hl.exec_cmd("tmux new-session -d -s 'config' 'cd ~/.files && nvim .'")
  end,
  alacritty = function()
    hl.exec_cmd("alacritty -e tmux new-session -As home", { fullscreen = true })
  end,
  obsidian = function()
    hl.exec_cmd("alacritty -e tmux_obsidian.sh", { workspace = "special:obsidian silent", fullscreen = true })
  end,
  suwayomi = function()
    hl.exec_cmd("docker start suwayomi")
  end,
}
