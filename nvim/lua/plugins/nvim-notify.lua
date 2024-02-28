return {
  "rcarriga/nvim-notify",
  lazy = false,
  config = function()
    local notify = require("notify")
    local setup = {
      background_colour = "Normal",
      fps = 30,
      icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = ""
      },
      level = 2,
      minimum_width = 50,
      render = "default",
      stages = "fade_in_slide_out",
      timeout = 3000,
      top_down = true
    }
    notify.setup(setup)
    -- vim.notify = notify.notify -- Globally set this so it's used everywhere
  end,
  priority = 1, -- Attempt to ensure this is loaded before all else, so I can see errors/warnings more clearly
}
