---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "oxocarbon",
  transparency = true,
  telescope = { style = "bordered" },
  cmp = {
    style = "default",
    selected_item_bg = "simple",
  },

  statusline = {
    theme = "vscode",
    separator_style = "block",
  },
  nvdash = { load_on_startup = true },
}

M.plugins = "custom.plugins"

M.mappings = require "custom.mappings"

return M
