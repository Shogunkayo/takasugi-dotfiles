--[[
require('base16-colorscheme').setup({
    base00 = '#242528', base01 = '#2a2e2f', base02 = '#373b41', base03 = '#7e827d',
    base04 = '#9e9d9f', base05 = '#d6d6d6', base06 = '#e0e0e0', base07 = '#d6d6d6',
    base08 = '#c64955', base09 = '#f6b573', base0A = '#f0c674', base0B = '#84ce80',
    base0C = '#8db8ae', base0D = '#7aaad1', base0E = '#a857b9', base0F = '#a3685a'
})

require("no-clown-fiesta").setup({
  transparent = true, -- Enable this to disable the bg color
  styles = {
    -- You can set any of the style values specified for `:h nvim_set_hl`
    comments = {},
    functions = {
    },
    keywords = {
    },
    lsp = { underline = true },
    match_paren = {},
    type = {
        bold = true,
    },
    variables = {},
  },
})
--]]


require "telescope".setup {
  pickers = {
    colorscheme = {
      enable_preview = true
    }
  }
}
