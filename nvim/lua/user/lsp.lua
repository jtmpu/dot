local M = {}

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
