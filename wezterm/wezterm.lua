local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.font = wezterm.font_with_fallback {
  'Hack Nerd Font',
  '나눔스퀘어'
}

config.color_scheme = 'Tokyo Night (Gogh)'
config.window_background_opacity = 0.97

return config
