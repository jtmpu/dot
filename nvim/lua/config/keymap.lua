local M = {}
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

-- Marks and bookmark navigation
local harpoon = require("harpoon")
vim.keymap.set("n", "<C-f>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-g>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-m>", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<C-t>", function() harpoon:list():select(5) end)
vim.keymap.set("n", "<C-,>", function() harpoon:list():select(6) end)
-- Plugin and leader-heavy binds
local wk = require("which-key")
local telescope = require("telescope.builtin")
local config_dir = vim.fn.stdpath("config")

wk.add({
    { "<leader>b", group = "buffer" },
    { "<leader>bc", "<cmd>enew<cr><cmd>bd #<cr>", desc = "close" },
    { "<leader>bC", "<cmd>enew<cr><cmd>%bd<cr>", desc = "close all" },
    { "<leader>e", group = "explorer" },
    { "<leader>eb", "<cmd>Neotree focus source=buffers<cr>", desc = "buffers" },
    { "<leader>ef", "<cmd>Neotree focus source=filesystem<cr>", desc = "filesystem" },
    { "<leader>eg", "<cmd>Neotree focus source=git_status<cr>", desc = "git" },
    { "<leader>d", group = "diagnostics" },
    { "<leader>dd", function() telescope.diagnostics() end, desc = "diagnostics search" },
    { "<leader>dw", function() require("trouble").toggle("workspace_diagnostics") end, desc = "workspace show" },
    { "<leader>dq", function() telescope.quickfix() end, desc = "quickfixes search" },
    { "<leader>dQ", function() require("trouble").toggle("quickfix") end, desc = "quickfixes show" },
    { "<leader>f", group = "find" },
    { "<leader>ff", function() telescope.git_files({ use_git_root = false }) end, desc = "files (git)" },
    { "<leader>fF", function() telescope.find_files() end, desc = "files (all)" },
    { "<leader>fg", function() telescope.live_grep() end, desc = "grep" },
    { "<leader>fb", function() telescope.buffers() end, desc = "buffers" },
    { "<leader>ft", "<cmd>Telescope<cr>", desc = "telescope" },
    { "<leaderfq", function() telescope.quickfix() end, desc = "quickfix" },
    { "<leader>fs", function() telescope.git_status() end, desc = "git-status" },
    { "<leader>g", group = "git-toggles" },
    { "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "blame", },
    { "<leader>gl", "<cmd>Gitsigns toggle_linehl<cr>", desc =  "line highlight", },
    { "<leader>gw", "<cmd>Gitsigns toggle_word_diff<cr>", desc = "word highlight", },
    { "<leader>gs", "<cmd>Gitsigns toggle_signs<cr>", desc =  "sign-col highlight", },
    { "<leader>m", group = "marks" },
    { "<leader>ma", function() harpoon:list():append() end, desc =  "add file to quick-nav", },
    { "<leader>mq", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "manage quick-nav", },
    { "<leader>ms", function() telescope.marks() end, desc =  "search marks", },
    { "<leader>c", group = "config" },
    { "<leader>cf", function() telescope.find_files({ cwd = config_dir }) end, desc =  "file", },
    { "<leader>cg", function() telescope.live_grep({ cwd = config_dir }) end, desc = "grep", },
    { "<leader>y", "\"+y", desc = "clipboard yank", },
})

--- Attachs LSP related keymaps to the specified buffer
-- The leader keys used via which-key is created globally though
function M.lsp_attach(bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
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
    --[[
    vim.keymap.set('n', '<leader>lca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>lrr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>lrn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>lf', function()
        vim.lsp.buf.format { async = true }
    end, bufopts)
    ]]
    --
end

return M
