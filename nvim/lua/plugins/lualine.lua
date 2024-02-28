return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local lualine = require("lualine")
    local working_directory = function() 
      local path = vim.fn.getcwd()
      rendered_path = string.match(path, "/([^/]+)$")
      return rendered_path
    end
    local lsp_status = function()
      local clients = vim.lsp.get_active_clients()
      if table.getn(clients) <= 0 then
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
        disabled_filetypes = {
          statusline = {},
          winbar = {
            "help",
            "startify",
            "dashboard",
            "packer",
            "neogitstatus",
            "NvimTree",
            "Trouble",
            "alpha",
            "lir",
            "Outline",
            "spectre_panel",
            "toggleterm",
          },
        },
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
        lualine_c = {"diagnostics"},
        lualine_x = {"encoding"},
        lualine_y = {"diff"},
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
      extensions = {},
    }

    lualine.setup(setup)
  end,
}
