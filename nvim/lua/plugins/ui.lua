return {
  -- colorscheme
  {
    'Mofiqul/dracula.nvim',
    lazy = false,
    name = "dracula",
    priority = 1000,
    config = function()
      require("dracula").setup({
        transparent_bg = true,
      })
      vim.cmd([[colorscheme dracula]])
    end,
  },
  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true, opt = true },
  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          component_separators = "",
          section_separators = "",
          theme = "dracula"
        },
        sections = {
          lualine_a = { { "mode", fmt = function(str) return str:sub(1, 1) end } },
          lualine_y = { { "datetime", style = "%H:%M %Y/%m/%d" } },
        },
      })
    end,
  },
  -- bufferline
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      -- 'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = { 
      animation = false,
      icons = { separator = { left = '', right = '' } }
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
  -- window bar
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      -- "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {},
  },
  -- file explorer
  {
    "stevearc/oil.nvim",
    -- dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = { { "-", "<CMD>Oil<CR>", desc = "Open File Explorer" } },
    config = function()
      require("oil").setup({
        view_options = { show_hidden = true },
        keymaps = {
          ["h"] = "actions.parent",
          ["l"] = "actions.select",
          ["q"] = "actions.close",
          ["<C-h>"] = false,
          ["<C-l>"] = false,
        },
      })
    end,
  },
  -- indent
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
      }
    }
  }
}

