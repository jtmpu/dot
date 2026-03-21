local lspc = require("user.lsp")
local server = "python"

local root_dir = vim.fs.root(0, { ".git", ".lsp" }) or vim.fn.expand("%:p:h")

local settings = lspc.load_settings(root_dir, server, {
    cmd = { "pyright-langserver", "--stdio" },
    ["pyright-langserver"] = {},
})

if not settings then
    vim.notify("[python:lsp] no LSP settings found, aborting", vim.log.levels.ERROR)
    return
end

-- enable LSP
lspc.attach({
    name = server,
    ---@diagnostic disable-next-line
    cmd = settings["cmd"],
    -- lua-language-server looks for .luarc.json in the workspace
    root_dir = root_dir,
    settings = settings,
})
