-- A nicer status bar
return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local lualine = require("lualine")
    local working_directory = function()
      local path = vim.fn.getcwd()
      local rendered_path = string.match(path, "/([^/]+)$")
      return rendered_path
    end
    local lsp_status = function()
      local clients = vim.lsp.get_active_clients()
      if table.maxn(clients) <= 0 then
          return "LSP Inactive"
      else
          return "LSP Active"
      end
    end
    local setup = {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = {working_directory},
        lualine_b = {"branch"},
        lualine_c = {{'filename', file_status = false, path = 1}},
        -- TODO: Show identifed language instead?
        lualine_x = {"filetype"},
        lualine_y = {"diff", "diagnostics"},
        -- TODO: show which server used? Count?
        lualine_z = {lsp_status}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {
        "neo-tree",
        "fugitive",
        "trouble",
      },
    }

    lualine.setup(setup)
  end,
}
