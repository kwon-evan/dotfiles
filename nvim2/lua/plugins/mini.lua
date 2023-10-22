return {
  {
    'echasnovski/mini.nvim', version = '*',
    lazy = false,
    config = function ()
      require('mini.files').setup({
        windows = {
          preview = true,
          width_preview = 50,
        }
      })
      require('mini.comment').setup()
      require('mini.fuzzy').setup()
      require('mini.cursorword').setup()
      require('mini.hipatterns').setup()
      require('mini.indentscope').setup({
        draw = {
          delay = 0,
          animation = require('mini.indentscope').gen_animation.none(),
        },
        symbol = "│"
      })
      require('mini.starter').setup()
      require('mini.pairs').setup()
      require('mini.tabline').setup()
      require('mini.statusline').setup()
    end,
    keys = {
      -- File Explorer
       { "<leader>f", "<cmd>lua MiniFiles.open()<cr>", mode = "n" },
      -- buffer nav
       { "<tab>", "<cmd>bnext<cr>", mode = "n" },
       { "<S-tab>", "<cmd>bprev<cr>", mode = "n" }
    }
  }
}
