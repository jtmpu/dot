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

-- Normal mode binds
local normal_opts = {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
    expr = false,
}
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
})
wk.register({
    f = {
        name = "find",
        f = {
            function() telescope.git_files({ use_git_root = false }) end,
            "files (git)",
        },
        F = {
            function() telescope.find_files() end,
            "files (all)",
        },
        g = {
            function() telescope.live_grep() end,
            "grep",
        },
        b = {
            function() telescope.buffers() end,
            "buffers",
        },
        t = {
            "<cmd>Telescope<cr>",
            "telescope",
        },
        w = {
            function()
                local word = vim.fn.expand("<cword>")
                telescope.grep_string({ search = word })
            end,
            "grep (<cword>)"
        },
        W = {
            function()
                local word = vim.fn.expand("<cWORD>")
                telescope.grep_string({ search = word })
            end,
            "grep (<cWORD>)"
        },
        q = {
            function() telescope.quickfix() end,
            "quickfix",
        },
        s = {
            function() telescope.git_status() end,
            "git-status",
        },
    },
    g = {
        name = "git-toggles",
        b = {
            "<cmd>Gitsigns toggle_current_line_blame<cr>",
            "blame",
        },
        l = {
            "<cmd>Gitsigns toggle_linehl<cr>",
            "line highlight",
        },
        w = {
            "<cmd>Gitsigns toggle_word_diff<cr>",
            "word highlight",
        },
        s = {
            "<cmd>Gitsigns toggle_signs<cr>",
            "sign-col highlight",
        },
    },
    m = {
        name = "marks",
        a = {
            function() harpoon:list():append() end,
            "add file to quick-nav",
        },
        q = {
            function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            "manage quick-nav",
        },
        s = {
            function() telescope.marks() end,
            "search marks",
        },
    },
    c = {
        name = "config",
        f = {
            function() telescope.find_files({ cwd = config_dir }) end,
            "file",
        },
        g = {
            function() telescope.live_grep({ cwd = config_dir }) end,
            "grep",
        },
    },
    y = { "\"+y", "clipboard yank" },
    Y = { "\"+y", "clipboard yank line" },
}, normal_opts)

-- Visual mode binds (pretty yanky atm with leader == space)
local visual_opts = {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
    expr = false,
}
wk.register({
    y = { "\"+y", "clipboard yank" },
}, visual_opts)

--- Attachs LSP related keymaps to the specified buffer
-- The leader keys used via which-key is created globally though
function M.lsp_attach(bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)

    local opts = {
        mode = "n",
        prefix = "<leader>",
        buffer = bufopts.buffer,
        silent = true,
        noremap = true,
        nowait = false,
        expr = false,
    }
    wk.register({
        l = {
            name = "lsp",
            a = { function() vim.lsp.buf.code_action() end, "code action" },
            r = {
                name = "reference",
                c = {
                    function() require("telescope.builtin").lsp_incoming_calls() end,
                    "incoming calls"
                },
                C = {
                    function() require("telescope.builtin").lsp_outgoing_calls() end,
                    "outgoing calls"
                },
                r = {
                    function() require("telescope.builtin").lsp_references() end,
                    "list"
                },
                n = { function() vim.lsp.buf.rename() end, "rename" },
            },
            f = {
                function() vim.lsp.buf.format({ async = true }) end,
                "format",
            },
            s = {
                function() require("telescope.builtin").lsp_document_symbols() end,
                "symbols (buffer)",
            }
        }
    }, opts)
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
