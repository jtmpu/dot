local lspc = require("config.lsp")

lspc.start({
    name = 'lua-language-server',
    cmd = {'lua-language-server'},
    -- lua-language-server looks for .luarc.json in the workspace
    root_dir = vim.fs.root(0, {'.luarc.json'})
})
