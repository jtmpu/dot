local lspc = require("user.lsp")
local server = "rust"

local root_dir = vim.fs.root(0, { ".git" }) or vim.fn.expand("%:p:h")

local settings = lspc.load_settings(root_dir, server, {
    cmd = { "rust-analyzer" },
    [server] = {
        ["rust-analyzer"] = {
            check = {
                command = "clippy",
            },
            cargo = {
                allFeatures = true,
            },
            procMacro = {
                enable = true,
            },
        },
    }
})

if not settings then
    return
end

-- enable LSP
lspc.attach({
    name = server,
    cmd = settings["cmd"],
    -- lua-language-server looks for .luarc.json in the workspace
    root_dir = root_dir,
    settings = settings[server],
})
