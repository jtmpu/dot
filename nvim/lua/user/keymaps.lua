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

--- Add LSP keymaps to buffers running an LSP client
--- @param bufopts vim.keymap.set.Opts
function M.lsp(bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    --[[
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
    ]] --
end

return M
