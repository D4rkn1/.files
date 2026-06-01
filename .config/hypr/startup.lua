hl.on("hyprland.start", function()
  hl.exec_cmd("alacritty")
  hl.dsp.exec_cmd("tmux_init.sh")
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
