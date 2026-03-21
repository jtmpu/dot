local lspc = require("user.lsp")
local server = "Lua"
local cmd = {
    "lua-language-server",
}

local settings = {
    [server] = {
        runtime = {
            version = "LuaJIT",
        },
        workspace = {
            library = {
                "${3rd}/luv/library",
                vim.env.VIMRUNTIME,
            },
            checkThirdParty = false,
        },
        telemetry = {
            enable = false,
        },
    }
}

-- enable LSP
lspc.attach({
    name = server,
    cmd = cmd,
    -- lua-language-server looks for .luarc.json in the workspace
    root_dir = vim.fs.root(0, {".git"}),
    settings = settings,
})
