local lspc = require("user.lsp")
local server = "pyright-langserver"
local cmd = {
    "pyright-langserver",
    "--stdio",
}

local settings = {
    [server] = {}
}

-- enable LSP
lspc.attach({
    name = server,
    cmd = cmd,
    -- lua-language-server looks for .luarc.json in the workspace
    root_dir = vim.fs.root(0, {".git"}),
    settings = settings,
})
