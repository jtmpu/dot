local M = {}

--- Configures global LSP related settings
function M.init()
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
            require("user.keymaps").lsp(opts)
        end,
    })
end

--- Attaches the current buffer to a configure LSP server
--- @param config vim.lsp.ClientConfig
function M.attach(config)
    local bufnr = vim.api.nvim_get_current_buf()
    local ok, blink = pcall(require, "blink.cmp")
    if ok then
        config.capabilities = blink.get_lsp_capabilities(config.capabilities)
    else
        vim.notify("blink.cmp not installed, skipping completion", vim.log.levels.WARN)
    end

    local opts = {
        bufnr = bufnr,
    }
    return vim.lsp.start(config, opts)
end

return M
