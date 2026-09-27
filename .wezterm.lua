-- Pull in the wezterm API
local wezterm = require "wezterm"

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- Changing the color scheme:
-- config.color_scheme = "rose-pine"
-- config.color_scheme = "Rosé Pine (Gogh)"
-- config.color_scheme = 'Gruvbox Dark (Gogh)'
config.color_scheme = 'terafox'
-- config.color_scheme = "Gruvbox Dark (Gogh)"

config.hide_tab_bar_if_only_one_tab = true

-- config.font = wezterm.font "Fira Mono"
-- config.font = wezterm.font "Zed Mono"
config.font = wezterm.font "Roboto Mono for Powerline"

config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

-- config.window_background_opacity = 0.9

-- and finally, return the configuration to wezterm
return config

