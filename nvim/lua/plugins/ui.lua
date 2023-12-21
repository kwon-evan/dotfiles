return {
  -- colorscheme
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    name = "dracula",
    priority = 1000,
    config = function()
      local pallete = require("dracula").colors()
      require("dracula").setup({ colors = { bg = pallete.black } })
      vim.cmd([[colorscheme dracula]])
    end,
  },
  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true, opt = true },
  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "BufEnter",
    dependencies = { "arkav/lualine-lsp-progress" },
    config = function()
      require("lualine").setup({
        options = {
          component_separators = "",
          section_separators = "",
          theme = "auto",
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(str)
                return str:sub(1, 1)
              end,
            },
          },
          lualine_x = { { "lsp_progress" }, "filetype" },
          lualine_y = { { "datetime", style = "%H:%M %Y/%m/%d" } },
        },
      })
    end,
  },
  -- bufferline
  {
    "romgrk/barbar.nvim",
    event = "BufEnter",
    dependencies = {
      "lewis6991/gitsigns.nvim",
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      animation = false,
      icons = { separator = { left = "", right = "" } },
    },
  },
  -- window bar
  {
    "utilyre/barbecue.nvim",
    event = "BufEnter",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
    },
    opts = {},
  },
  -- file explorer
  {
    "stevearc/oil.nvim",
    event = "VimEnter",
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
      vim.cmd([[autocmd vimenter * ++nested ++once lua require("oil").open()]])
    end,
  },
  -- indent
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    main = "ibl",
    opts = {
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
      },
    },
  },
}
