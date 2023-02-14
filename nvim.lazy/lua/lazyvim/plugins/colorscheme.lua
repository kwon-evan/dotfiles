return {
  -- nightfox
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    name = "nightfox",
    config = function()
      local nightfox = require("nightfox")
      nightfox.setup({
        transparent = true,
        styles = {
          comments = "italic",
          keywords = "bold",
        },
      })
      nightfox.load()
      vim.cmd("colorscheme carbonfox")
    end,
  },

  -- tokyonight
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local tokyonight = require("tokyonight")
      tokyonight.setup({ style = "night" })
      tokyonight.load()
    end,
  },

  -- catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },
}
