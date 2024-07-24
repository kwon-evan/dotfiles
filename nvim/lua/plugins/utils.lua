return {
  -- which key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {},
  },

  -- toggleterm
  {
    "akinsho/toggleterm.nvim",
    lazy = true,
    config = function()
      local toggleterm = require("toggleterm")
      toggleterm.setup({
        start_in_insert = false,
        size = 80,
        direction = "vertical",
      })
    end,
    keys = {
      {
        "<leader>t",
        function()
          require("toggleterm").toggle()
        end,
        desc = "ToggleTerm",
      },
      {
        "<leader>e",
        function()
          local excuter = vim.fn.expand("%:e")
          if excuter == "py" then
            excuter = "python3 "
          elseif excuter == "sh" then
            excuter = "bash "
          elseif excuter == "rs" then
            excuter = "rustc "
          else
            excuter = ""
          end

          if excuter ~= "" then
            local cmd = '"' .. excuter .. vim.fn.expand("%:p") .. '"'
            require("toggleterm").exec_command("cmd=" .. cmd)
          else
            vim.notify("Not support file type", "warning")
          end
        end,
        desc = "Execute Current File",
      },
    },
  },

  -- bracket auto close
  {
    "utilyre/sentiment.nvim",
    version = "*",
    dependencies = {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      opts = {},       -- this is equalent to setup({}) function
    },
    event = "BufRead", -- keep for lazy loading
    opts = {},
    init = function()
      vim.g.loaded_matchparen = 1
    end,
  },

  -- floating preview
  {
    "rmagatti/goto-preview",
    event = "BufRead",
    opts = function()
      require("goto-preview").setup({
        height = 45,
        default_mappings = true,
      })
    end,
  },

  -- comment
  { "numToStr/Comment.nvim", event = "BufRead", opts = {} },

  -- visual surround
  {
    "NStefan002/visual-surround.nvim",
    config = true,
  },

  -- remote dev
  {
    "amitds1997/remote-nvim.nvim",
    version = "*",                     -- Pin to GitHub releases
    dependencies = {
      "nvim-lua/plenary.nvim",         -- For standard functions
      "MunifTanjim/nui.nvim",          -- To build the plugin UI
      "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
    },
    config = true,
  },

  -- html tag auto close
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    ft = { "html", "svelte", "markdown" },
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
  }
}
