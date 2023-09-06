---@type ChadrcConfig
local M = {}

M.ui = {
  extended_integrations = { "notify" },
  theme = "oxocarbon",
  telescope = { style = "borderless" },
  cmp = {
    lspkind_text = false,
    style = "atom",
    selected_item_bg = "simple",
  },

  statusline = {
    theme = "vscode",
    separator_style = "block",
  },

  nvdash = {
    load_on_startup = true,
    -- TODO: update this!
    header = {
      "                                 ",
      "             NEOVIM              ",
      "                                 ",
    }
  },
}

M.plugins = "custom.plugins"

M.mappings = require("custom.mappings")

return M
