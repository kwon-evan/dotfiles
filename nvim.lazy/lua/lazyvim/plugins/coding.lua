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
    -- stylua: ignore
    -- keys = {
    --   {
    --     "<tab>",
    --     function()
    --       return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
    --     end,
    --     expr = true, remap = true, silent = true, mode = "i",
    --   },
    --   { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
    --   { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    -- },
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
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
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
            ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            ["<Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
              -- they way you will only jump inside the snippet region
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
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "buffer" },
            { name = "path" },
            { name = "emoji" },
          }),
          formatting = {
            format = function(_, item)
              local icons = require("lazyvim.config.settings").icons.kinds
              if icons[item.kind] then
                item.kind = icons[item.kind] .. item.kind
              end
              return item
            end,
          },
          confirm_opts = {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
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

  -- comments
  { "JoosepAlviste/nvim-ts-context-commentstring" },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    config = function()
      require("mini.comment").setup({
        hooks = {
          pre = function()
            require("ts_context_commentstring.internal").update_commentstring({})
          end,
        },
      })
    end,
  },

  -- better text-objects
  {
    "echasnovski/mini.ai",
    keys = {
      { "a", mode = { "x", "o" } },
      { "i", mode = { "x", "o" } },
    },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function()
          -- no need to load the plugin, since we only need its queries
          require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
        end,
      },
    },
    config = function()
      local ai = require("mini.ai")
      ai.setup({
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        },
      })
    end,
  },

  {
    "simrat39/symbols-outline.nvim",
    config = function()
      local so = require("symbols-outline")
      so.setup({
        with = 15,
      })
    end,
    keys = {
      { "<F2>", ":SymbolsOutline<CR>" },
    },
  },

  {
    "rmagatti/goto-preview",
    config = function()
      local gtp = require("goto-preview")
      gtp.setup({
        width = 120,
        height = 40,
      })
    end,
    keys = {
      { "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", desc = "Goto Definition" },
      { "gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", desc = "Goto Type Definition" },
      { "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", desc = "Goto Implementation" },
      { "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>", desc = "All Preview Windows Close" },
      { "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", desc = "Goto References" },
    },
  },

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

  {
    "zbirenbaum/copilot.lua",
    event = "VeryLazy",
    config = function()
      vim.keymap.set("i", "<Tab>", function()
        if require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").accept()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
        end
      end, {
        silent = true,
      })
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
          accept = false,
        },
      })
    end,
  },
}
