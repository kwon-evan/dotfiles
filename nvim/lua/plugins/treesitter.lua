return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false, -- v1.0.0 does not support lazy loading
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")

      ts.setup({
        -- Use default values for now
      })

      -- Install parsers
      ts.install({
        -- vim
        "vim",
        "vimdoc",
        -- note
        "comment",
        "markdown",
        "markdown_inline",
        -- shell
        "bash",
        -- languages
        "lua",
        "c",
        "rust",
        "python",
        "html",
        "css",
        "javascript",
        "typescript",
        "svelte",
      })

      -- Enable highlighting and indentation using Autocommands (v1.0.0 way)
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local ok, _ = pcall(vim.treesitter.start)
          if ok then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}