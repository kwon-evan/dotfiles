vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  end,
})

local function get_keys(t)
  local keys = {}
  for key, _ in pairs(t) do
    table.insert(keys, key)
  end
  return keys
end

local languages = {
  -- lua
  lua_ls = { { Lua = { diagnostics = { globals = { "vim", "describe", "it" } } } } },
  -- python
  pyright = { { pyright = { disableOrganizeImports = true } } }, -- Using Ruff's import organizer
  ruff_lsp = {},
  -- rust
  rust_analyzer = {},
  -- bash
  bashls = {},
  -- web
  html = {},
  cssls = {},
  tsserver = {},
  tailwindcss = {},
}

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local on_attach = function(client, bufnr)
        if client.name == "ruff_lsp" then
          client.server_capabilities.hoverProvider = false
        end
      end

      for language, settings in pairs(languages) do
        require("lspconfig")[language].setup({
          capabilities = capabilities,
          settings = settings,
          on_attach = on_attach,
        })
      end

      vim.lsp.handlers["textDocument/publishDiagnostics"] =
          vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = false,
          })
    end,
    keys = {
      { "<leader>d", vim.diagnostic.open_float, desc = "LSP Diagnostic" },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  -- mason <-> lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = get_keys(languages),
      automatic_installation = true,
    },
  },
}
