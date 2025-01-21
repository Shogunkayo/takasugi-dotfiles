function ColorMyPencils(color)
	-- color = color or "no-clown-fiesta"
    color = color or "skull"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "NormalFloat", {
        bg = "none"
    })

    vim.api.nvim_set_hl(0, "Function", {
        fg = "#a67768",
    })

    vim.api.nvim_set_hl(0, "Special", {
        fg = "#f9cc9e",
    })

    vim.api.nvim_set_hl(0, "String", {
        fg = "#8dc48a",
    })

    vim.api.nvim_set_hl(0, "Comment", {
        fg = "#5e6a5e",
    })

    vim.api.nvim_set_hl(0, "Foreground", {
        fg = "#bfbfbf",
    })

    vim.api.nvim_set_hl(0, "@variable", {
        link = "Foreground",
    })

    vim.api.nvim_set_hl(0, "@punctuation", {
        link = "Foreground"
    })

end

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '/', right = '/'},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

ColorMyPencils()

