local lspc = require("config.lsp")
local server = "rust-analyzer"
local cmd = {
    "rust-analyzer",
}

-- My rust repos are always git
local root_dir = vim.fs.root(0, { ".git" })
if not root_dir then
    return
end

local settings = {
    [server] = {
        check = {
            command = "clippy",
        },
        cargo = {
            allFeatures = true,
        },
        procMacro = {
            enable = true,
        },
    }
}

lspc.start({
    name = 'rust-analyzer',
    cmd = cmd,
    root_dir = root_dir,
    settings = settings,
    init_options = settings['rust-analyzer'],
})
