-- ensure we run TSUpdate when updating the plugin
vim.api.nvim_create_autocmd('PackChanged', { callback = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
  if name == 'nvim-treesitter' and kind == 'update' then
    if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
    vim.cmd('TSUpdate')
  end
end })
vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})
-- This is a no-op if languages are already installed
local ts = require("nvim-treesitter")
ts.setup({
    install_dir = vim.fn.stdpath('data') .. '/site',
})
ts.install({
    "lua",
    "bash",
})
