return {
  -- which key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {}
  },

  -- toggleterm
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    config = function()
      local toggleterm = require("toggleterm")
      toggleterm.setup({
        start_in_insert = false,
      })

      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
      local vertical = Terminal:new({hidden = true, direction = "vertical", width = 80})

      -- lazygit
      local function _lazygit_toggle()
        lazygit:toggle()
      end

      -- select executer by filename
      local function _excute()
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
          toggleterm.exec_command("direction=vertical size=80 cmd=" .. cmd)
        else
          vim.notify("Not support file type", "warning")
        end
      end

      local _toggle = function()
        vertical:toggle()
      end

      vim.keymap.set("n", "<leader>g", _lazygit_toggle, { desc = "Lazygit" })
      vim.keymap.set("n", "<leader>e", _excute, { desc = "Excute" })
      toggleterm.setup()
    end,
    keys = {
      { "<leader>t", "<cmd>ToggleTerm direction=vertical size=80<cr>", desc = "ToggleTerm" },
    },
  },

  -- bracket auto close
  {
    "utilyre/sentiment.nvim",
    version = "*",
    dependencies = {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      opts = {},        -- this is equalent to setup({}) function
    },
    event = "VeryLazy", -- keep for lazy loading
    opts = {},
    init = function()
      vim.g.loaded_matchparen = 1
    end,
  },

  -- floating preview
  {
    'rmagatti/goto-preview',
    lazy = true,
    opts = function()
      require('goto-preview').setup {
        height = 45,
        default_mappings = true,
      }
    end
  },

  -- comment
  { 'numToStr/Comment.nvim', event = "VeryLazy", opts = {} }
}
