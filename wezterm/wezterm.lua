local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.font = wezterm.font_with_fallback({
  "Hack Nerd Font",
  "나눔스퀘어",
})

config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

config.color_scheme = 'Material Darker (base16)'
config.window_background_opacity = 0.97

return config
