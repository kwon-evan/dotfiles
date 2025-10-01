return {
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require('dracula').setup({
        show_end_of_buffer = true,
        transparent_bg = true,
      })
      vim.cmd("colorscheme dracula")
    end,
  },
  -- {
  --   "EdenEast/nightfox.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("nightfox").setup({
  --       transparent = true,
  --       dim_inactive = true,
  --     })
  --     vim.cmd("colorscheme carbonfox")
  --   end
  -- },
  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true },
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
        skip_confirm_for_simple_edits = true,
      })
      vim.cmd([[autocmd vimenter * ++nested ++once lua require("oil").open()]])
    end,
  },
  -- indent
  {
    "echasnovski/mini.indentscope",
    event = { "BufReadPre", "BufNewFile" },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "neotree",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
      local indent = require("mini.indentscope")
      indent.setup({
        symbol = "│",
        draw = { animation = indent.gen_animation.none() },
        options = { try_as_border = true },
      })
    end,
  },
}
