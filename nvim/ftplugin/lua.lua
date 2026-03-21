local lspc = require("user.lsp")
local server = "lua"

local root_dir = vim.fs.root(0, { ".git" }) or vim.fn.expand("%:p:h")

local settings = lspc.load_settings(root_dir, server, {
    cmd = { "lua-language-server" },
    [server] = {
        ["Lua"] = {
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
