---@type ChadrcConfig
local M = {}

M.ui = { theme = "chadracula" }
M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"

-- vim.diagnostic.config { virtual_text = false }

return M
