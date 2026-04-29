-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

local theme = require("themes.gruvbox")

-- colors
config.colors = theme.colors

-- fonts
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 14

-- background
config.window_background_gradient = theme.background_gradient
config.window_background_opacity = theme.background_opacity or 0.5
config.macos_window_background_blur = theme.macos_window_background_blur

-- title bar and tab bar
config.window_decorations = "RESIZE|INTEGRATED_BUTTONS"

-- key mapping
config.keys = {
	{
		key = "n",
		mods = "SHIFT|CTRL",
		action = wezterm.action.ToggleFullScreen,
	},
}

-- return the configuration to wezterm
return config
