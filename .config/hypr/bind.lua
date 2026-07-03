local mainMod = "SUPER"
local programs = require("programs")
local path = require("path")

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(programs.terminal))
hl.bind(mainMod .. " + grave", hl.dsp.submap("mpv"))
hl.define_submap("mpv", function()
  hl.bind("p", hl.dsp.exec_cmd("play.sh selectplaylist"))
  hl.bind("p", hl.dsp.submap("reset"))
  hl.bind("a", hl.dsp.exec_cmd("play.sh volup"), { repeating = true })
  hl.bind("a", hl.dsp.submap("reset"))
  hl.bind("r", hl.dsp.exec_cmd("play.sh voldown"), { repeating = true })
  hl.bind("r", hl.dsp.submap("reset"))
  hl.bind("1", hl.dsp.exec_cmd("play.sh next"))
  hl.bind("1", hl.dsp.submap("reset"))
  hl.bind("2", hl.dsp.exec_cmd("play.sh prev"))
  hl.bind("2", hl.dsp.submap("reset"))
  hl.bind("q", hl.dsp.exec_cmd("play.sh stop"))
  hl.bind("q", hl.dsp.submap("reset"))
  hl.bind("w", hl.dsp.exec_cmd("play.sh pause"))
  hl.bind("w", hl.dsp.submap("reset"))
  hl.bind("i", hl.dsp.exec_cmd("play.sh stat"))
  hl.bind("i", hl.dsp.submap("reset"))
  hl.bind("x", hl.dsp.exec_cmd("play.sh addplaylist"))
  hl.bind("x", hl.dsp.submap("reset"))
  hl.bind("f", hl.dsp.exec_cmd("play.sh find"))
  hl.bind("f", hl.dsp.submap("reset"))
  hl.bind("SPACE", hl.dsp.submap("reset"))
end)

hl.bind(mainMod .. " + A", hl.dsp.submap("scr"))
hl.define_submap("scr", function()
  hl.bind(
    "R",
    hl.dsp.exec_cmd("grim " .. path.saved_img .. "$(date +'%Y-%m-%d-%H%M%S').png && notify-send -u low 'png'")
  )
  hl.bind("R", hl.dsp.submap("reset"))
  hl.bind(
    "W",
    hl.dsp.exec_cmd(
      "grim - | ffmpeg -f image2pipe -vcodec png -i - -q:v 2 "
        .. path.saved_img
        .. "$(date +'%Y-%m-%d-%H%M%S').jpg && notify-send -u low 'jpg'"
    )
  )
  hl.bind("W", hl.dsp.submap("reset"))
  hl.bind(
    "S",
    hl.dsp.exec_cmd(
      'grim -g "$(slurp)" - | ffmpeg -f image2pipe -vcodec png -i - -q:v 2 '
        .. path.saved_img
        .. "$(date +'%Y-%m-%d-%H%M%S').jpg"
    )
  )
  hl.bind("S", hl.dsp.submap("reset"))
  hl.bind("T", hl.dsp.exec_cmd([[slurp | grim -g - - | wl-copy && notify-send -u low "clip"]]))
  hl.bind("T", hl.dsp.submap("reset"))
  hl.bind("TAB", hl.dsp.exec_cmd("catbox.sh"))
  hl.bind("TAB", hl.dsp.submap("reset"))
  hl.bind("Q", hl.dsp.exec_cmd("sul.sh"))
  hl.bind("Q", hl.dsp.submap("reset"))
  hl.bind("SPACE", hl.dsp.submap("reset"))
end)

hl.bind(mainMod .. " + P", hl.dsp.submap("repo"))
hl.define_submap("repo", function()
  hl.bind("f", hl.dsp.exec_cmd(programs.repo .. " find"))
  hl.bind("f", hl.dsp.submap("reset"))
  hl.bind("s", hl.dsp.exec_cmd(programs.repo .. " create"))
  hl.bind("s", hl.dsp.submap("reset"))
  hl.bind("SPACE", hl.dsp.submap("reset"))
end)
hl.bind(mainMod .. " + TAB", hl.dsp.submap("programs"))
hl.define_submap("programs", function()
  hl.bind("f", hl.dsp.exec_cmd(programs.browser))
  hl.bind("f", hl.dsp.submap("reset"))
  hl.bind("q", hl.dsp.exec_cmd(programs.menu))
  hl.bind("q", hl.dsp.submap("reset"))
  hl.bind("r", hl.dsp.exec_cmd(programs.rec))
  hl.bind("r", hl.dsp.submap("reset"))
  hl.bind("SPACE", hl.dsp.submap("reset"))
end)
hl.bind(mainMod .. " + t", hl.dsp.workspace.toggle_special("clock"))
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("pkill -SIGUSR1 wayscriber"))

hl.bind(mainMod .. " + Q", hl.dsp.exit())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd(programs.fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SPACE", hl.dsp.window.fullscreen({ action = "toggle" }))
-- hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

hl.bind(mainMod .. " + S", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
  hl.bind("i", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
  hl.bind("m", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
  hl.bind("n", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
  hl.bind("e", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
  hl.bind("SPACE", hl.dsp.submap("reset"))
end)

hl.bind(mainMod .. " + R", hl.dsp.submap("travel"))
hl.define_submap("travel", function()
  hl.bind("M", hl.dsp.focus({ direction = "left" }))
  hl.bind("I", hl.dsp.focus({ direction = "right" }))
  hl.bind("E", hl.dsp.focus({ direction = "up" }))
  hl.bind("N", hl.dsp.focus({ direction = "down" }))
  hl.bind("SPACE", hl.dsp.submap("reset"))
end)

for i = 1, 10 do
  local key = i % 10
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + W", hl.dsp.workspace.toggle_special("obsidian"))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(
  "XF86AudioRaiseVolume",
  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
  { locked = true, repeating = true }
)
hl.bind(
  "XF86AudioLowerVolume",
  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true, repeating = true }
)
hl.bind(
  "XF86AudioMute",
  hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
  { locked = true, repeating = true }
)
hl.bind(
  "XF86AudioMicMute",
  hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
  { locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("play.sh next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("play.sh pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("play.sh pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("play.sh prev"), { locked = true })
hl.bind("XF86Tools", hl.dsp.exec_cmd("play.sh start"), { locked = true })

hl.bind("F9", function()
  local cur = hl.get_config("cursor.zoom_factor")
  if cur == 4.0 then
    hl.config({ cursor = { zoom_factor = 1.0} })
  else
    hl.config({ cursor = { zoom_factor = 4.0} })
  end
end)
