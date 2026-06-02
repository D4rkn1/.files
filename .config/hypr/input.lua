hl.config({
  input = {
    follow_mouse = 1,

    sensitivity = 0,

    touchpad = {
      natural_scroll = false,
      disable_while_typing = false,
      drag_lock = 0,
    },
  },
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace",
})

hl.device({
  name = "epic-mouse-v1",
  sensitivity = -0.5,
})

