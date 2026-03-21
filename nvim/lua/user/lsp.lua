local M = {}

local ERROR = vim.log.levels.ERROR

--- Loads the LSP settings from a file, used to store specific configurations
--- within the repository. If none is found, the default settings are returned
--- Cmd is stored in settings["cmd"]
--- @param root_dir string root directory of the repository
--- @param server string the LSP server name, e.g. rust-analyzer
--- @param default table<string, boolean|string|number|unknown[]|nil|any>?
--- @return table<string, boolean|string|number|unknown[]|nil|any>?
function M.load_settings(root_dir, server, default)
    local path = vim.fs.joinpath(root_dir, ".lsp", server .. ".json")
    local status, lines = pcall(vim.fn.readfile, path)

    if not default then
        vim.notify("[lsp:custom-settings] default is missing '" .. server .. "'", ERROR)
        return nil
    end

    if not default["cmd"] then
        vim.notify("[lsp:custom-settings] default is missing cmd key '" .. server .. "'", ERROR)
        return nil
    end

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

    if not settings["cmd"] then
        settings["cmd"] = default["cmd"]
    end

    return settings
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
