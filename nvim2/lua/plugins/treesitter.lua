return {
   {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
         require("nvim-treesitter.configs").setup({
            auto_install = true,
            ensure_installed = {
               "c",
               "rust",
               "python",
               "lua",
               "vim",
               "html",
               "css",
               "comment",
               "vimdoc",
            },
            highlight = { enable = true },
            indent = { enable = true },
            autotag = { enable = true },
         })
      end,
   },
   {
      "nvim-treesitter/nvim-treesitter-context",
      config = function()
         vim.cmd("hi TreesitterContextBottom gui=underdashed guisp=#585b70")
      end
   },
}
