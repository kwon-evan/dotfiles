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

local languages = {
	-- lua
	"lua_ls",
	-- python
	"pyright",
	-- "ruff_lsp",
	-- rust
	"rust_analyzer",
	-- bash
	"bashls",
	-- web
	"html",
	"cssls",
	"tsserver",
	"tailwindcss",
}

local linters = {
	-- lua
	-- python
	"ruff",
	-- rust
	-- bash
	-- web
	"eslint_d",
}

local formatters = {
	-- lua
	"stylua",
	-- python
	-- rust
	"rust_analyzer",
	-- bash
	"beautysh",
	-- web
	"prettier",
}

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = { "hrsh7th/cmp-nvim-lsp" },
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			require("lspconfig").lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim", "describe", "it" },
						},
					},
				},
			})

			for _, language in pairs(languages) do
				require("lspconfig")[language].setup({
					capabilities = capabilities,
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
			ensure_installed = languages,
			automatic_installation = true,
		},
	},
	-- mason <-> none-ls
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = vim.tbl_flatten({ linters, formatters }),
				automatic_installation = true,
			})
		end,
	},
}
