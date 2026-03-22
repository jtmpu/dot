local lspc = require("user.lsp")
local server = "bash"

local root_dir = vim.fs.root(0, { ".git" }) or vim.fn.expand("%:p:h")
lspc.enable_fold(server)
lspc.attach_with_override(server, {
    name = server,
    root_dir = root_dir,
    cmd = { "bash-language-server", "start", },
    settings = {
        ["bash-language-server"] = {},
    },
})
