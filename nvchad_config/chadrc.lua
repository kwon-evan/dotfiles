---@type ChadrcConfig
local M = {}

vim.opt.scrolloff = 12

M.ui = {
  extended_integrations = { "notify" },
  theme = "chadracula",
  telescope = { style = "borderless" },
  transparency = true,
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
      "  ,-.       _,---._ __  / \\  ",
      " /  )    .-'       `./ /   \\ ",
      "(  (   ,'            `/    /|",
      " \\  `-\"             \\'\\   / |",
      "  `.              ,  \\ \\ /  |",
      "   /`.          ,'-`----Y   |",
      "  (            ;        |   '",
      "  |  ,-.    ,-'         |  / ",
      "  |  | (   |            | /  ",
      "  )  |  \\  `.___________|/   ",
      "  `--'   `--'     NEOVIM     "
    },
  },
}

M.plugins = "custom.plugins"

M.mappings = require("custom.mappings")

return M
