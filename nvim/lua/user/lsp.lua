local M = {}

--- Enable tree-sitter folding
--- @param server string the ftype being enabled
function M.enable_fold(server)
    local ok, result = pcall(require, "nvim-treesitter")
    if not ok then
        M.warn(server, "folding: treesitter doesn't exist")
        return
    end
    local ts = result

    ok, result = pcall(ts.install, { server })
    if not ok then
        M.warn(server, "folding: failed to install treesitter language: " .. result)
        return
    end

    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.opt_local.foldlevel = 99
end

--- Loads the LSP config from a file, used to store specific configurations
--- within the repository. If none is found, the default settings are returned
--- Cmd is stored in settings["cmd"]
--- @param server string the LSP server name, e.g. rust-analyzer
--- @param default table<string, boolean|string|number|unknown[]|vim.NIL>
--- @return table<string, boolean|string|number|unknown[]|vim.NIL>?
function M.load_settings(server, default)
    if not default then
        M.error(server, "no default settings specified")
        return nil
    end

    if not default["cmd"] then
        M.error(server, "default is missing cmd key")
        return nil
    end

    local root_dir = default["root_dir"]
    if type(root_dir) ~= "string" then
        return default
    end

    local path = vim.fs.joinpath(root_dir, ".lsp", server .. ".json")
    local status, lines = pcall(vim.fn.readfile, path)

    if not status then
        return default
    end

    M.warn("using overriden config: " .. path)

    local data = table.concat(lines, "\n")
    local jsonstatus, settings = pcall(vim.json.decode, data)
    if not jsonstatus then
        M.error(server, "invalid json: " .. settings)
        return nil
    end

    if not settings["settings"] then
        M.error(server, "expected at least empty settings key")
        return nil
    end
    default["settings"] = settings["settings"]
    return default
end

--- Check and returns client if it's running
--- @param server string the server name
--- @param config table<string, boolean|string|number|unknown[]|vim.NIL>
function M.is_running(server, config)
    local root_dir = config["root_dir"]
    if type(root_dir) ~= "string" then
        root_dir = ""
    end
    local clients = vim.lsp.get_clients({ name = server })
    for _, client in ipairs(clients) do
        if client.root_dir and client.root_dir:find(root_dir, 1, true) then
            return true, client
        end
    end
    return false, nil
end

--- Attaches the current buffer to a configure LSP server
--- @param server string the LSP server name, e.g. rust-analyzer
--- @param config table<string, boolean|string|number|unknown[]|vim.NIL> the LSP config
--- @return integer?
function M.spawn(server, config)
    local bufnr = vim.api.nvim_get_current_buf()

    local cmd = config["cmd"]
    if not cmd[1] then
        M.error(server, "invalid cmd specified: " .. cmd)
        return
    end
    local binary = cmd[1]

    if vim.fn.executable(binary) == 0 then
        M.error(server, "executable not found: '" .. binary .. "'")
        return
    end

    local ok, blink = pcall(require, "blink.cmp")
    if ok then
        config.capabilities = blink.get_lsp_capabilities(config.capabilities)
    else
        M.error(server, "blink.cmp not installed, skipping completion")
    end

    local opts = {
        bufnr = bufnr,
    }
    return vim.lsp.start(config, opts)
end

--- Attaches the current buffer to a configure LSP server
--- @param server string the LSP server name, e.g. rust-analyzer
--- @param config table<string, boolean|string|number|unknown[]|vim.NIL> the LSP config
--- @return integer?
function M.attach(server, config)
    local running, client = M.is_running(server, config)
    if running and client then
        vim.lsp.buf_attach_client(0, client.id)
        return client.id
    end

    return M.spawn(server, config)
end

--- Attaches to an LSP with support for a project-local LSP override file
--- Cmd is stored in settings["cmd"]
--- @param server string the LSP server name, e.g. rust-analyzer
--- @param default table<string, boolean|string|number|unknown[]|vim.NIL>
--- @return integer?
function M.attach_with_override(server, default)
    local running, client = M.is_running(server, default)
    if running and client then
        vim.lsp.buf_attach_client(0, client.id)
        return client.id
    end

    local settings = M.load_settings(server, default)
    if not settings then
        M.error(server, "no LSP settings found, aborting")
        return
    end
    -- enable LSP
    return M.spawn(server, settings)
end

--- Notification wrapper
--- @param server string related LSP server
--- @param msg string message to print
function M.error(server, msg)
    vim.notify("[lsp:" .. server .. "]: " .. msg, vim.log.levels.ERROR)
end

function M.warn(server, msg)
    vim.notify("[lsp:" .. server .. "]: " .. msg, vim.log.levels.WARN)
end

return M
