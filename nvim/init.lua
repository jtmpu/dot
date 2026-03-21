--- Install and configure plugins
local function plugins()
    -- Plugin hooks
    vim.api.nvim_create_autocmd('PackChanged', { callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        -- ensure we run TSUpdate when updating the plugin
        if name == 'nvim-treesitter' and kind == 'update' then
            if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
            vim.cmd('TSUpdate')
        end
    end })

    -- Download and add plugin sources
    vim.pack.add({
        -- Theme
        { src = "https://github.com/folke/tokyonight.nvim", version = "main" },
        -- Autocomplete: blink.cmp
        { src = "https://github.com/rafamadriz/friendly-snippets", version = "main" },
        { src = "https://github.com/saghen/blink.cmp", version = "v1.10.0" },
        -- Notifications and LSP progress
        { src = "https://github.com/rcarriga/nvim-notify", version = "master" },
        { src = "https://github.com/j-hui/fidget.nvim", version = "main" },
        -- Shaded lines in indentation
        { src = "https://github.com/lukas-reineke/indent-blankline.nvim", version = "master" },
        -- Git icons inline
        { src = "https://github.com/lewis6991/gitsigns.nvim", version = "main" },
        -- Syntax highlighting with treesitter
        { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
        -- Leader-binds floating window visualization
        { src = "https://github.com/folke/which-key.nvim", version = "main" },
        --- Fast-picker with telescope
        { src = "https://github.com/nvim-lua/plenary.nvim", version = "v0.1.4" },
        { src = "https://github.com/nvim-telescope/telescope.nvim", version = "v0.2.1" },
        -- Diagnostics with trouble
        { src = "https://github.com/folke/trouble.nvim", version = "main" },
        -- File explorer/manipulation with oil
        { src = "https://github.com/stevearc/oil.nvim", version = "master" },
    })

    -- Configure plugins
    require("tokyonight").setup({
        style = "storm",
    })

    require("blink.cmp").setup({
        keymap = { preset = "default" },
        appearance = {
            nerd_font_variant = 'mono'
        },
        completion = {
            documentation = { auto_show = false }
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },
        fuzzy = {
            implementation = "prefer_rust_with_warning",
        },
    })

    -- override global notification system
    vim.notify = require("notify")
    require("fidget").setup({
        progress = {
            display = {
                -- Group multiple items from the same LSP
                group_items = true,
                -- Collapse them into a single line if they are similar
                collapse = true,
            },
        },
    })

    require("ibl").setup()

    require("gitsigns").setup({
        signs = {
            add          = { text = '│' },
            change       = { text = '│' },
            delete       = { text = '_' },
            topdelete    = { text = '‾' },
            changedelete = { text = '~' },
            untracked    = { text = '┆' },
        },
        -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame = false,
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = 'eol',
            delay = 250,
            ignore_whitespace = false,
            virt_text_priority = 100,
        },
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    })

    -- This is a no-op if languages are already installed
    local ts = require("nvim-treesitter")
    ts.setup({
        install_dir = vim.fn.stdpath('data') .. '/site',
    })
    ts.install({
        "lua",
        "bash",
    })

    require("which-key").setup({
        icons = {
            breadcrumb = "»",
            separator = "➜",
            group = "󰉗 ",
        },
    })

    require("trouble").setup({})
    local open_with_trouble = require("trouble.sources.telescope").open
    require("telescope").setup({
        defaults = {
            mappings = {
                i = { ["<c-t>"] = open_with_trouble },
                n = { ["<c-t>"] = open_with_trouble },
            },
        },
    })

    require("oil").setup({
        float = {
            -- Padding is the distance from the edge of the editor window
            padding = 2,
            max_width = 0, -- Set to 0 to use the full width
            max_height = 0,
            border = "rounded", -- "single", "double", "shadow", "rounded"
            win_options = {
              winblend = 20, -- 0 is fully opaque, 100 is fully transparent
            },
        }
    })
end

--- Global settings in the editor
local function settings()
    -- Leader
    vim.g.mapleader = ' '

    -- Tabs, indents
    vim.opt.expandtab = true
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 4
    vim.opt.smartindent = true
    vim.opt.autoindent = true

    vim.opt.clipboard = "unnamedplus"

    vim.opt.updatetime = 300
    vim.opt.timeoutlen = 500

    vim.opt.undodir = vim.fn.expand("$HOME") .. "/.vimdid"
    vim.opt.undofile = true

    vim.cmd.colorscheme("tokyonight")
    vim.opt.termguicolors = true

    vim.opt.wrap = false
    vim.opt.scrolloff = 8
    vim.opt.signcolumn = "yes:1"

    vim.opt.encoding = "utf-8"
    vim.opt.fileencoding = "utf-8"
    vim.opt.guicursor = ""

    vim.opt.ignorecase = true -- ignore case letters in search
    vim.opt.smartcase = true  -- ignore lowercase for whole pattern

    vim.wo.number = true
    vim.o.mouse = ""

    -- Searching
    vim.opt.hlsearch = false
    vim.opt.incsearch = true
end

--- Configure global LSP settings
local function lsp()
    -- Show diagnostics while writing, and print overview text
    vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = true,
        severity_sort = true,
    })

    -- Attach keymappings for LSP-enabled buffers
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
            local opts = { buffer = event.buf }
            -- require("user.keymaps").lsp(opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

            local wk = require("which-key")
            wk.add({
                { "<leader>l", group = "lsp" },
                { "<leader>la", function() vim.lsp.buf.code_action() end, desc = "code action" },
                { "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, desc = "format", },
                { "<leader>ls", function() require("telescope.builtin").lsp_document_symbols() end, desc = "symbols (buffer)", },
                { "<leader>lrc", function() require("telescope.builtin").lsp_incoming_calls() end, desc = "ref (incoming calls)" },
                { "<leader>lrC", function() require("telescope.builtin").lsp_outgoing_calls() end, desc = "ref (outgoing calls)" },
                { "<leader>lrr", function() require("telescope.builtin").lsp_references() end, desc = "ref (list)" },
                { "<leader>lrn", function() vim.lsp.buf.rename() end, desc = "ref (rename)" },
            })
        end,
    })
end

local function keymaps()
    local keymap = vim.api.nvim_set_keymap
    local default_opts = { noremap = true, silent = true }
    -- Window navigation
    keymap("n", "<C-h>", "<C-w>h", default_opts)
    keymap("n", "<C-j>", "<C-w>j", default_opts)
    keymap("n", "<C-k>", "<C-w>k", default_opts)
    keymap("n", "<C-l>", "<C-w>l", default_opts)

    -- Naviagate buffers
    keymap("n", "<S-l>", ":bnext<CR>", default_opts)
    keymap("n", "<S-h>", ":bprevious<CR>", default_opts)

    -- Move text and maintain selection
    keymap("v", "J", ":m '>+1<CR>gv=gv", default_opts)
    keymap("v", "K", ":m '<-2<CR>gv=gv", default_opts)
    keymap("v", "<", "<gv", default_opts)
    keymap("v", ">", ">gv", default_opts)

    -- Better scrolling
    keymap("n", "<C-d>", "<C-d>zz", default_opts)
    keymap("n", "<C-u>", "<C-u>zz", default_opts)

    -- Leader binds
    local telescope = require("telescope.builtin")
    local config_dir = vim.fn.stdpath("config")
    local wk = require("which-key")
    wk.add({
        { "<leader>b", group = "buffer" },
        { "<leader>bc", "<cmd>enew<cr><cmd>bd #<cr>", desc = "close" },
        { "<leader>bC", "<cmd>enew<cr><cmd>%bd<cr>", desc = "close all" },

        { "<leader>e", group = "explorer" },
        { "<leader>ef", function() vim.cmd(":Oil --float") end, desc = "open explorer"},

        { "<leader>g", group = "git" },
        { "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "blame", },
        { "<leader>gl", "<cmd>Gitsigns toggle_linehl<cr>", desc =  "line highlight", },
        { "<leader>gw", "<cmd>Gitsigns toggle_word_diff<cr>", desc = "word highlight", },
        { "<leader>gs", "<cmd>Gitsigns toggle_signs<cr>", desc =  "sign-col highlight", },

        { "<leader>d", group = "diagnostics" },
        { "<leader>dd", function() telescope.diagnostics() end, desc = "diagnostics search" },
        { "<leader>dq", function() telescope.quickfix() end, desc = "quickfixes search" },
        { "<leader>dQ", function() require("trouble").toggle("quickfix") end, desc = "quickfixes show" },

        { "<leader>f", group = "find" },
        { "<leader>ff", function() telescope.git_files({ use_git_root = false }) end, desc = "files (git)" },
        { "<leader>fF", function() telescope.find_files() end, desc = "files (all)" },
        { "<leader>fg", function() telescope.live_grep() end, desc = "grep" },
        { "<leader>fb", function() telescope.buffers() end, desc = "buffers" },

        { "<leader>c", group = "config" },
        { "<leader>co", function() vim.cmd(":edit " .. vim.fs.joinpath(config_dir, "init.lua") ) end, desc =  "open init.lua", },
        { "<leader>cf", function() telescope.find_files({ cwd = config_dir }) end, desc =  "find", },
        { "<leader>cg", function() telescope.live_grep({ cwd = config_dir }) end, desc = "grep", },
    })
end

plugins()
settings()
lsp()
keymaps()
