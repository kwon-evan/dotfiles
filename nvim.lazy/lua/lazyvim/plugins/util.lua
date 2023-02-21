return {

  -- measure startuptime
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },

  -- session management
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = { options = { "buffers", "curdir", "tabpages", "winsize", "help" } },
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Delete Current Session" },
    },
  },

  -- library used by other plugins
  "nvim-lua/plenary.nvim",

  -- toggle terminal
  {
    "akinsho/toggleterm.nvim",
    config = function()
      local tt = require("toggleterm")
      tt.setup({
        size = 20,
        close_on_exit = true,
      })
    end,
    keys = {
      { "<F5>", "<cmd>ToggleTerm size=65 direction=vertical<CR>" },
      { "<F6>", "<cmd>ToggleTerm direction=horizontal<CR>" },
      { "<F9>", "<cmd>TermExec cmd='python %:p'<CR>" },
    },
  },

  -- Markdown Preview
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreview<CR>" },
    },
  },
}
