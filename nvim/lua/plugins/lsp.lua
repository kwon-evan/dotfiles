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

-- Automatically load LSP servers from lsp/ directory
local function get_lsp_servers()
  local lsp_path = vim.fn.stdpath("config") .. "/lsp"
  local servers = {}

  if vim.fn.isdirectory(lsp_path) == 1 then
    local files = vim.fn.readdir(lsp_path)
    for _, file in ipairs(files) do
      if file:match("%.lua$") then
        local server_name = file:gsub("%.lua$", "")
        table.insert(servers, server_name)
      end
    end
  end

  return servers
end

return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = get_lsp_servers(),
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

      -- 모든 LSP 서버에 공통 설정 적용
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

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
