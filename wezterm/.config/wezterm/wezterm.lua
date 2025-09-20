-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- fonts
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 14

-- colorschemes
local nord = wezterm.color.get_builtin_schemes()["Nord (Gogh)"]
nord.foreground = "#BCC5CE"
config.color_schemes = {
	["Custom Nord"] = nord,
}
config.color_scheme = "Custom Nord"

-- background
config.window_background_gradient = {
	orientation = { Linear = { angle = -45.0 } },
	colors = {
        "#232831",
        "#3b4252",
        "#445d7c",
    },
	interpolation = "Linear",
	blend = "Rgb",
}
config.window_background_opacity = 1.0
config.macos_window_background_blur = 20

-- title bar and tab bar
config.window_decorations = "RESIZE"
config.colors = {
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
