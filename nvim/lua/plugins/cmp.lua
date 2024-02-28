return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "hrsh7th/cmp-buffer",           -- Buffer Completions
    "hrsh7th/cmp-path",             -- Path Completions
    "hrsh7th/cmp-nvim-lsp",         -- LSP Completions
    "hrsh7th/cmp-nvim-lua",         -- Lua Completions
    "hrsh7th/cmp-cmdline",          -- CommandLine Completions
  },
  config = function()
    local cmp = require "cmp"

    local kind_icons = {
      Text = "󰉿",
      Method = "󰆧",
      Function = "󰊕",
      Constructor = "",
      Field = "󰜢",
      Variable = "",
      Class = "󰠱",
      Interface = "",
      Module = "",
      Property = "󰜢",
      Unit = "󰑭",
      Value = "󰎠",
      Enum = "",
      Keyword = "󰌋",
      Snippet = "",
      Color = "󰏘",
      File = "󰈙",
      Reference = "󰈇",
      Folder = "󰉋",
      EnumMember = "",
      Constant = "󰏿",
      Struct = "󰙅",
      Event = "",
      Operator = "󰆕",
      TypeParameter = "󰊄",
    }

    cmp.setup {
      mapping = cmp.mapping.preset.insert {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1)),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1)),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-e>"] = cmp.mapping {
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        },
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm { select = false },
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
      },
      formatting = {
        format = function(_, vim_item)
          vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
          return vim_item
        end,
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "buffer" },
        { name = "path" },
      },
      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },
      window = {
        completion = cmp.config.window.bordered {
          border = "rounded",
          winhighlight = "Normal:Normal,FloatBorder:CmpCompletionBorder,CursorLine:CmpCursorLine,Search:Search",
          col_offset = -3,
          side_padding = 1,
        },
        documentation = cmp.config.window.bordered {
          border = "rounded",
          winhighlight = "Normal:Normal,FloatBorder:CmpDocumentationBorder,CursorLine:CmpCursorLine,Search:Search",
          col_offset = -3,
          side_padding = 1,
        },
      },
      experimental = {
        ghost_text = true,
      },
    }

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "cmdline" },
      },
      window = {
        completion = cmp.config.window.bordered {
          border = "rounded",
          winhighlight = "Normal:Normal,FloatBorder:CmpCompletionBorder,CursorLine:CmpCursorLine,Search:Search",
          col_offset = -3,
          side_padding = 1,
        },
      },
      formatting = {
        -- fields = { 'abbr' },
        format = function(_, vim_item)
          vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
          return vim_item
        end,
      },
    })
  end,
}
