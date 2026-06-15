local cmd = require("startcmd")
hl.on("hyprland.start", function()
  cmd.bg()
  cmd.clock()
  cmd.config()
  cmd.alacritty()
  cmd.obsidian()
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
