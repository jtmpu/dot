local M = {}

--- Register common keymappings
function M.init()
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
end

--- Registers high level which-key data
function M.which_key()
    local wk = require("which-key")
    wk.add({
        { "<leader>b", group = "buffer" },
        { "<leader>bc", "<cmd>enew<cr><cmd>bd #<cr>", desc = "close" },
        { "<leader>bC", "<cmd>enew<cr><cmd>%bd<cr>", desc = "close all" },

        { "<leader>e", group = "explorer" },
        { "<leader>d", group = "diagnostics" },
        { "<leader>f", group = "find" },
        { "<leader>c", group = "config" },
    })
end

--- Register telescope binds
function M.telescope()
    local telescope = require("telescope.builtin")
    local config_dir = vim.fn.stdpath("config")
    local wk = require("which-key")
    wk.add({
        { "<leader>dd", function() telescope.diagnostics() end, desc = "diagnostics search" },
        { "<leader>dq", function() telescope.quickfix() end, desc = "quickfixes search" },
        { "<leader>dQ", function() require("trouble").toggle("quickfix") end, desc = "quickfixes show" },

        { "<leader>ff", function() telescope.git_files({ use_git_root = false }) end, desc = "files (git)" },
        { "<leader>fF", function() telescope.find_files() end, desc = "files (all)" },
        { "<leader>fg", function() telescope.live_grep() end, desc = "grep" },
        { "<leader>fb", function() telescope.buffers() end, desc = "buffers" },

        { "<leader>cf", function() telescope.find_files({ cwd = config_dir }) end, desc =  "file", },
        { "<leader>cg", function() telescope.live_grep({ cwd = config_dir }) end, desc = "grep", },
    })
end

--- Register gitsigns binds
function M.gitsigns()
    local wk = require("which-key")
    wk.add({
        { "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "blame", },
        { "<leader>gl", "<cmd>Gitsigns toggle_linehl<cr>", desc =  "line highlight", },
        { "<leader>gw", "<cmd>Gitsigns toggle_word_diff<cr>", desc = "word highlight", },
        { "<leader>gs", "<cmd>Gitsigns toggle_signs<cr>", desc =  "sign-col highlight", },
    })
end

--- Add LSP keymaps to buffers running an LSP client
--- @param bufopts vim.keymap.set.Opts
function M.lsp(bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)

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
end

return M
