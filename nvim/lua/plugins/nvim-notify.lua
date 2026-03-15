return {
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 3000,
      render = "compact", -- or "default"
      stages = "fade_in_slide_out",
    },
    config = function(_, opts)
      local notify = require("notify")
      notify.setup(opts)
      -- This line is the magic: it tells Neovim to use this plugin for all vim.notify calls
      vim.notify = notify
    end,
  },
}
