local overrides = require "custom.configs.overrides"
---@type NvPluginSpec[]
local plugins = {
  -- Override plugin definition options
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = overrides.trouble,
  },

  -- completion
  {
    "hrsh7th/nvim-cmp",
    opts = {
      sources = {
        { name = "codeium",  group_index = 2 },
        { name = "nvim_lsp", group_index = 2 },
        { name = "luasnip",  group_index = 2 },
        { name = "buffer",   group_index = 2 },
        { name = "nvim_lua", group_index = 2 },
        { name = "path",     group_index = 2 },
      },
    },
  },

  -- nice, noise, notice
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = overrides.noice,
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        config = function()
          require("notify").setup(overrides.notify)
        end,
      },
    },
  },

  -- better escape
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- f to jump
  {
    "ggandor/flit.nvim",
    event = "VeryLazy",
  },

  -- floating window preview
  {
    "rmagatti/goto-preview",
    config = function()
      local gtp = require "goto-preview"
      gtp.setup {
        width = 120,
        height = 40,
      }
    end,
  },

  -- edit markdown in neovim
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = "markdown",
  },

  -- Neovim-Tmux navigation
  {
    "alexghergh/nvim-tmux-navigation",
    event = "VeryLazy",
    config = function()
      local nvim_tmux_nav = require "nvim-tmux-navigation"
      nvim_tmux_nav.setup {
        disable_when_zoomed = true,
      }
    end,
  },

  -- telekasten
  {
    "renerocksai/telekasten.nvim",
    event = "VeryLazy",
    -- lazy = false,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "renerocksai/calendar-vim",
    },
    config = function()
      local telekasten = require "telekasten"
      telekasten.setup {
        home = vim.fn.expand "~/문서/Obsidian Vault/",
      }
    end,
  },

  -- codeium
  {
    "Exafunction/codeium.nvim",
    event = "InsertEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup()
    end,
  },

  {
    "folke/twilight.nvim",
    event = "VeryLazy",
  },

  {
    "folke/zen-mode.nvim",
    event = "VeryLazy",
  },
}

return plugins
