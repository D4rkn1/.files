hl.on("hyprland.start", function()
  hl.exec_cmd("swaybg -i $(fd -e jpg -e jpeg -e png . $HOME/wallpapers | shuf -n1) -m fill")
  hl.exec_cmd("tmux new-session -d -s home")
  hl.exec_cmd("alacritty -e tmux a -t home")
  hl.exec_cmd("d4ssh.sh")
end)

hl.config({
  misc = {
    force_default_wallpaper = 0,
    disable_hyprland_logo = true,
  },
  ecosystem = {
    no_update_news = true,
    no_donation_nag = true,
  },
})
