local lspc = require("user.lsp")
local server = "lua"

local root_dir = vim.fs.root(0, { ".git", ".luarc" }) or vim.fn.expand("%:p:h")

lspc.enable_fold(server)
lspc.attach(server, {
    name = server,
    cmd = { "lua-language-server" },
    root_dir = root_dir,
    settings = {
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
    },
})
