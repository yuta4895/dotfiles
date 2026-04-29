local M = {}

M.colors = {
  ansi = {
    "#3b4252",
    "#bf616a",
    "#a3be8c",
    "#ebcb8b",
    "#81a1c1",
    "#b48ead",
    "#88c0d0",
    "#e5e9f0",
  },
  brights = {
    "#4c566a",
    "#bf616a",
    "#a3be8c",
    "#ebcb8b",
    "#81a1c1",
    "#b48ead",
    "#8fbcbb",
    "#eceff4",
  },
  cursor_bg = "#d8dee9",
  cursor_border = "#d8dee9",
  cursor_fg = "#2e3440",
  background = "#2e3440",
  foreground = "#C2BFB3",
  indexed = {},
  tab_bar = {
    background = "#8fbcbb",
    active_tab = {
      bg_color = "#88C0D0",
      fg_color = "#2E3440",
    },
    inactive_tab = {
      bg_color = "#4C566A",
      fg_color = "#D8DEE9",
    },
  },
}

M.background_gradient = {
  orientation = { Linear = { angle = -45.0 } },
  colors = {
    "#20242B",
    "#2B3037",
    "#3C434E",
  },
  interpolation = "Linear",
  blend = "Rgb",
}
M.background_opacity = 1.0
M.macos_window_background_blur = 20

return M
