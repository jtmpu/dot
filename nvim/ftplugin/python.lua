local lspc = require("user.lsp")
local server = "python"

local root_dir = vim.fs.root(0, { ".git", "Cargo.toml", })
if not root_dir then
    vim.notify("[rust:lsp] no root dir found, not spawning")
    return
end

local settings = lspc.load_settings(root_dir, server, {
    cmd = { "pyright-langserver", "--stdio" },
    [server] = {
        ["pyright-langserver"] = {},
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
