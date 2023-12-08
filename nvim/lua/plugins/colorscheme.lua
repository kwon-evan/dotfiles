return {
  -- {
  --   "Mofiqul/dracula.nvim",
  --   lazy = false,
  --   name = "dracula",
  --   priority = 1000,
  --   config = function()
  --     require("dracula").setup({
  --       colors = {
  --         bg = "#2b2b2b",
  --       },
  --       transparent_bg = true,
  --     })
  --     vim.cmd([[colorscheme dracula]])
  --   end,
  -- },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
        intergrations = {
          headlines = true,
          mason = true,
          fidget = true,
        }
      })

      vim.cmd([[colorscheme catppuccin]])
    end
  }
}
