local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

	-- Override plugin definition options
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- format & linting
			{
				"jose-elias-alvarez/null-ls.nvim",
				config = function()
					require("custom.configs.null-ls")
				end,
			},
		},
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end, -- Override to setup mason-lspconfig
	},

	-- override plugin configs
	{
		"williamboman/mason.nvim",
		opts = overrides.mason,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
	},

	{
		"nvim-tree/nvim-tree.lua",
		opts = overrides.nvimtree,
	},

	{
		"folke/trouble.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = overrides.trouble,
	},

	-- nice, noise, notice
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = overrides.noice,
		dependencies = {
			"MunifTanjim/nui.nvim",
			{
				"rcarriga/nvim-notify",
				config = function()
					require("notify").setup(overrides.notify)
				end,
			},
		},
	},

	-- better escape
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},

	-- f to jump
	{
		"ggandor/flit.nvim",
		event = "VeryLazy",
	},

	-- code assistant
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
		opts = overrides.copilot,
	},

	-- completion with copilot
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{
				"zbirenbaum/copilot-cmp",
				config = function()
					require("copilot_cmp").setup()
				end,
			},
		},
		opts = {
			sources = {
				{ name = "nvim_lsp", group_index = 2 },
				{ name = "copilot", group_index = 2 },
				{ name = "luasnip", group_index = 2 },
				{ name = "buffer", group_index = 2 },
				{ name = "nvim_lua", group_index = 2 },
				{ name = "path", group_index = 2 },
			},
		},
	},

	-- floating window preview
	{
		"rmagatti/goto-preview",
		config = function()
			local gtp = require("goto-preview")
			gtp.setup({
				width = 120,
				height = 40,
			})
		end,
	},

	-- edit markdown in neovim
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		ft = "markdown",
	},

	-- Neovim-Tmux navigation
	{
		"alexghergh/nvim-tmux-navigation",
		event = "VeryLazy",
		config = function()
			local nvim_tmux_nav = require("nvim-tmux-navigation")
			nvim_tmux_nav.setup({
				disable_when_zoomed = true,
			})
		end,
	},

	{
		"renerocksai/telekasten.nvim",
		lazy = false,
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"renerocksai/calendar-vim",
		},
		config = function()
			local telekasten = require("telekasten")
			telekasten.setup({
				home = vim.fn.expand("~/문서/Obsidian Vault/"),
			})
		end,
	},

	-- TODO: add telescope plugins
}

return plugins
