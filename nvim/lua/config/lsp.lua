local M = {}

---@param config vim.lsp.ClientConfig
function M.start(config)
    local bufnr = vim.api.nvim_get_current_buf()
    config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
    if not config.capabilities then
        vim.notify('failed to merge client config', vim.log.levels.ERROR)
        return
    end

    local opts = {
        bufnr = bufnr,
    }
    return vim.lsp.start(config, opts)
end

return M
