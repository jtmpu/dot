-- Only map LSP keys after langue server attaches
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local opts =  { buffer = ev.buf }
        -- Hook up my LSP buffer keybinds
        require("keymap").lsp_attach(opts)
    end,
})
