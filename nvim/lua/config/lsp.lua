local M = {}

local ERROR = vim.log.levels.ERROR

--- Loads the LSP settings from a file, used to store specific configurations
--- within the repository. If none is found, the default settings are returned
--- @param root_dir string root directory of the repository
--- @param server string the LSP server name, e.g. rust-analyzer
--- @param default table<string, boolean|string|number|unknown[]|nil|any>?
--- @return table<string, boolean|string|number|unknown[]|nil|any>?
function M.load_settings(root_dir, server, default)
    local path = vim.fs.joinpath(root_dir, ".lsp", server .. ".json")
    local status, lines = pcall(vim.fn.readfile, path)
    if not status then
        return default
    end

    local data = table.concat(lines, "\n")
    local jsonstatus, settings = pcall(vim.json.decode, data)
    if not jsonstatus then
        vim.notify("[lsp:custom-settings] invalid json: " .. settings, ERROR)
        return nil
    end

    if not settings[server] then
        vim.notify("[lsp:custom-settings] json is missing server key '" .. server .. "'", ERROR)
        return nil
    end

    return settings
end

--- Attaches the buffer to an LSP server if one exists, otherwise starts an LSP and attaches
--- to that
---@param config vim.lsp.ClientConfig
function M.start(config)
    local bufnr = vim.api.nvim_get_current_buf()
    config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
    if not config.capabilities then
        vim.notify('failed to merge client config', ERROR)
        return
    end

    local opts = {
        bufnr = bufnr,
    }
    return vim.lsp.start(config, opts)
end

return M
