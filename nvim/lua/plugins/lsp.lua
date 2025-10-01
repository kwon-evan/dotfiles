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
  pyright = {
    { pyright = { disableOrganizeImports = false } },
    { analysis = { diagnostics = false } },
  },
  ruff = {},
  -- rust
  rust_analyzer = {},
  -- bash
  bashls = {},
  -- web
  html = {},
  cssls = {},
  ts_ls = {},
  tailwindcss = {},
  svelte = {},
}

return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = get_keys(languages),
      automatic_enable = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = { 
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local on_attach = function(client, bufnr)
        if client.name == "ruff" then
          client.server_capabilities.hoverProvider = true
        end
      end

      -- Configure all LSP servers using vim.lsp.config()
      for language, settings in pairs(languages) do
        vim.lsp.config(language, {
          capabilities = capabilities,
          settings = settings,
          on_attach = on_attach,
        })
      end

      -- Enable all configured LSP servers
      for language, _ in pairs(languages) do
        vim.lsp.enable(language)
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
}
