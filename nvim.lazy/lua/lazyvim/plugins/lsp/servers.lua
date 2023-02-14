-- Add any servers here together with their settings
---@type lspconfig.options
local servers = {
  bashls = {},
  clangd = {},
  cssls = {},
  tsserver = {},
  html = {},
  jsonls = {},
  pyright = {
    args = { "--ignore=E501,E231", "-" },
  },
  yamlls = {},
  lua_ls = {
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
        },
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  },
}

return servers
