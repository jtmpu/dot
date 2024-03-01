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

    -- Nvim tree
    keymap("n", "<leader>E", ":NvimTreeToggle<cr>", opts)

    -- Trouble LSP pretty window
    vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
    vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
    vim.keymap.set("n", "<leader>xr", function() require("trouble").toggle("lsp_references") end)
    vim.keymap.set("n", "<leader>xc", function() require("trouble").close() end)

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
