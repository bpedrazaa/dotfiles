local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Font configuration
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "DemiBold", italic = false })
config.font_size = 10

-- Windows Geometry
config.initial_cols = 160
config.initial_rows = 40

-- Colors
config.color_scheme = "nord"
config.colors = {
	background = "black",
	split = "white",
	brights = {
		"#BBBBBB", -- bright black
		"#BF616A", -- bright red
		"#A3BE8C", -- bright green
		"#EBCB8B", -- bright yellow
		"#81A1C1", -- bright blue
		"#B48EAD", -- bright magenta
		"#8FBCBB", -- bright cyan
		"#ECEFF4", -- bright white
	},
}

-- Tab Bar
config.enable_tab_bar = false

-- Padding
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Background
config.window_background_opacity = 0.9

-- Default program
-- Set powershell as default shell
config.default_prog = { "powershell.exe", "-nologo" }

-- Leader key definition
config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 }

-- Key bindings
config.keys = {
	-- New tab
	{ key = "c", mods = "LEADER", action = wezterm.action.SpawnTab("CurrentPaneDomain") },

	-- Move to previous tab with Ctrl+Shift+h
	{ key = "h", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
	-- Move to next tab with Ctrl+Shift+l
	{ key = "l", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(1) },

	-- Split pane vertically
	{
		key = "|",
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	-- Split pane horizontally
	{
		key = "-",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	-- Move between panes
	{ key = "h", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "l", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "k", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "j", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Down") },
}

-- Return the configuration to wezterm:
return config
