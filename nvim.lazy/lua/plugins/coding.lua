return {
  -- snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    config = {
      history = true,
      delete_check_events = "TextChanged",
    },
  },

  -- auto completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-emoji",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
          return false
        end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
      end
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup(
        {
          completion = {
            completeopt = "menu,menuone,noinsert",
          },
          snippet = {
            expand = function(args)
              require("luasnip").lsp_expand(args.body)
            end,
          },
          mapping = cmp.mapping.preset.insert({
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = false,
            }),
            ["<Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() and has_words_before() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              elseif has_words_before() then
                cmp.complete()
              else
                fallback()
              end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { "i", "s" }),
          }),
          sources = cmp.config.sources({
            { name = "copilot" },
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "buffer" },
            { name = "path" },
            { name = "emoji" },
          }),
          formatting = {
            format = function(_, item)
              local icons = require("config.settings").icons.kinds
              if icons[item.kind] then
                item.kind = icons[item.kind] .. item.kind
              end
              return item
            end,
          },
          window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
          },
          experimental = {
            ghost_text = {
              hl_group = "LspCodeLens",
            },
          },
        },
        cmp.setup.filetype("gitcommit", {
          sources = cmp.config.sources({
            { name = "git" },
            { name = "buffer" },
          }),
        }),
        cmp.setup.cmdline({ "/", "?" }, {
          mhpping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = "nvim_lsp_document_symbol" },
            { name = "buffer" },
          }),
        }),
        cmp.setup.cmdline(":", {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = "cmdline" },
            { name = "cmdline_history" },
            { name = "path" },
          }),
        }),
        cmp.event:on("menu_opened", function()
          vim.b.copilot_suggestion_hidden = true
        end),
        cmp.event:on("menu_closed", function()
          vim.b.copilot_suggestion_hidden = false
        end)
      )
    end,
  },

  -- auto pairs
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    config = function()
      require("mini.pairs").setup({})
    end,
  },

  -- surround
  {
    "echasnovski/mini.surround",
    keys = { "gz" },
    config = function()
      -- use gz mappings instead of s to prevent conflict with leap
      require("mini.surround").setup({
        mappings = {
          add = "gza", -- Add surrounding in Normal and Visual modes
          delete = "gzd", -- Delete surrounding
          find = "gzf", -- Find surrounding (to the right)
          find_left = "gzF", -- Find surrounding (to the left)
          highlight = "gzh", -- Highlight surrounding
          replace = "gzr", -- Replace surrounding
          update_n_lines = "gzn", -- Update `n_lines`
        },
      })
    end,
  },

  -- code Analysis
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      local so = require("symbols-outline")
      so.setup({
        with = 15,
      })
    end,
    keys = {
      { "<F2>", "<cmd>SymbolsOutline<CR>" },
    },
  },

  -- Comment
  {
    "numToStr/comment.nvim",
    config = function()
      require("Comment").setup()
    end,
    keys = {
      { "<C-_>", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>j", mode = "n" },
      { "<C-_>", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>j", mode = "v" },
    },
  },
}
