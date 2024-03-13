return {
	{ -- Autoformat
		"stevearc/conform.nvim",
		opts = {
			notify_on_error = true,
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_lsp" },
				rust = { "rustfmt" },
				javascript = { { "prettierd", "prettier", "eslint_d" } },
				typescript = { { "prettierd", "prettier", "eslint_d" } },
				bash = { "shfmt" },
			},
		},
	},
}
