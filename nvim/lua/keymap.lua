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

-- Move text up and down
keymap("v", "J", ":m '>+1<CR>gv=gv", default_opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", default_opts)

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
wk.register({
    e = {
        name = "explorer",
        -- Neo tree explorer
        b = { "<cmd>Neotree focus source=buffers<cr>", "buffers" },
        f = { "<cmd>Neotree focus source=filesystem<cr>", "filesystem" },
        g = { "<cmd>Neotree focus source=git_status<cr>", "git" },
    },
    d = {
        name = "diagnostics",
        d = {
            function() telescope.diagnostics() end,
            "diagnostics search",
        },
        w = {
            function() require("trouble").toggle("workspace_diagnostics") end,
            "workspace show",
        },
        q = {
            function() telescope.quickfix() end,
            "quickfixes search",
        },
        Q = {
            function() require("trouble").toggle("quickfix") end,
            "quickfixes show",
        },
    },
    f = {
        name = "find",
        f = {
            function() telescope.git_files() end,
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
    },
    g = {
        name = "git",
        t = {
            name = "toggle",
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
        b = {
            "<cmd>:Git blame<cr>",
            "blame",
        },
        d = {
            "<cmd>:Gdiffsplit<cr>",
            "diff file",
        },
        D = {
            "<cmd>:Gdiffsplit<cr>",
            "diff all",
        },
        m = {
            "<cmd>:Git mergetool<cr>",
            "merge tool",
        }
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
                r = { function() vim.lsp.buf.references() end, "list" },
                n = { function() vim.lsp.buf.rename() end, "rename" },
            },
            f = {
                function() vim.lsp.buf.format({ async = true }) end,
                "format",
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
