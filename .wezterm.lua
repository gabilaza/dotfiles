local wezterm = require "wezterm"

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'terafox'

config.hide_tab_bar_if_only_one_tab = true

config.font = wezterm.font "Roboto Mono for Powerline"

config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

return config
