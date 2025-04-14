local lspc = require("config.lsp")

lspc.start({
    name = 'buck2',
    cmd = {'buck2', 'lsp',},
    -- lua-language-server looks for .luarc.json in the workspace
    root_dir = vim.fs.root(0, {'.buckroot'})
})
