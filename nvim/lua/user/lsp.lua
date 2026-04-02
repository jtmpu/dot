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
    return M.spawn(server, config)
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
