local M = {}
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

function M.global()
    -- Window navigation
    keymap("n", "<C-h>", "<C-w>h", opts)
    keymap("n", "<C-j>", "<C-w>j", opts)
    keymap("n", "<C-k>", "<C-w>k", opts)
    keymap("n", "<C-l>", "<C-w>l", opts)

    -- Naviagate buffers
    keymap("n", "<S-l>", ":bnext<CR>", opts)
    keymap("n", "<S-h>", ":bprevious<CR>", opts)

    -- Move text up and down
    keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
    keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

    -- Better scrolling
    keymap("n", "<C-d>", "<C-d>zz", opts)
    keymap("n", "<C-u>", "<C-u>zz", opts)

    -- Clipboard
    keymap("n", "<leader>y", "\"+y", opts)
    keymap("v", "<leader>y", "\"+y", opts)
    keymap("n", "<leader>Y", "\"+Y", opts)

    -- Neo tree explorer
    keymap("n", "<leader>eb", ":Neotree focus source=buffers<cr>", opts)
    keymap("n", "<leader>ef", ":Neotree focus source=filesystem<cr>", opts)
    keymap("n", "<leader>eg", ":Neotree focus source=git_status<cr>", opts)

    -- Trouble LSP pretty window
    vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
    vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
    vim.keymap.set("n", "<leader>xr", function() require("trouble").toggle("lsp_references") end)
    vim.keymap.set("n", "<leader>xc", function() require("trouble").close() end)

    -- Harpoon
    local harpoon = require("harpoon")
    vim.keymap.set("n", "<leader>ha", function() harpoon:list():append() end)
    vim.keymap.set("n", "<leader>hs", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
    vim.keymap.set("n", "<C-f>", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<C-g>", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<C-m>", function() harpoon:list():select(4) end)
    vim.keymap.set("n", "<C-t>", function() harpoon:list():select(5) end)
    vim.keymap.set("n", "<C-,>", function() harpoon:list():select(6) end)
end

--- Attachs LSP related keymaps to the specified buffer
-- The leader keys used via which-key is created globally though
function M.lsp_attach(bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    -- Which key magic?
    vim.keymap.set('n', '<leader>lca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>lrr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>lrn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>lf', function()
        vim.lsp.buf.format { async = true }
    end, bufopts)
end

return M
