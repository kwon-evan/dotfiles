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
        autochdir = true,
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          else
            return 20
          end
        end,
      })
    end,
    keys = {
      {
        "<leader>tt",
        function()
          local Terminal = require("toggleterm.terminal").Terminal
          local vertical_term = Terminal:new({ direction = "vertical" })
          vertical_term:toggle()
        end,
        desc = "ToggleTerm - Vertical",
      },
      {
        "<leader>th",
        function()
          local Terminal = require("toggleterm.terminal").Terminal
          local horizontal_term = Terminal:new({ direction = "horizontal" })
          horizontal_term:toggle()
        end,
        desc = "ToggleTerm - Horizontal",
      },
      {
        "<leader>tf",
        function()
          local Terminal = require("toggleterm.terminal").Terminal
          local floating_term = Terminal:new({ direction = "float" })
          floating_term:toggle()
        end,
        desc = "ToggleTerm - Floating",
      },
      {
        "<leader>te",
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
  },

  -- Symbol Outline
  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    opts = {
      symbol_folding = {
        auto_unfold = {
          only = 2,
        },
      },
      outline_window = {
        auto_jump = true,
      },
    },
  },

  -- lsp rename
  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup()
      vim.keymap.set("n", "<leader>rr", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end, { expr = true })
    end,
  },
}
