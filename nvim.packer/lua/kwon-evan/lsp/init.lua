local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "kwon-evan.lsp.mason"
require("kwon-evan.lsp.handlers").setup()
require "kwon-evan.lsp.null-ls"
