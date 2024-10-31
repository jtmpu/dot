local M = {}

---@param config vim.lsp.ClientConfig
function M.start(config)
    local bufnr = vim.api.nvim_get_current_buf()
    -- local cmp = require('cmp')
    -- local capabilities = require('cmp_nvim_lsp').default_capabilities()

    local merged = vim.tbl_deep_extend(
        'force',
        { capabilities = capabilities },
        config
    )

    if not merged then
        vim.notify('failed to merge client config', vim.log.levels.ERROR)
        return
    end

    local opts = {
        reuse_client = false,
        bufnr = bufnr,
    }
    return vim.lsp.start(merged, opts)
end

return M
