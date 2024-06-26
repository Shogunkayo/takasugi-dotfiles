local set = vim.opt

set.smarttab = true
set.expandtab = true
set.shiftwidth = 4
set.tabstop = 4

set.hlsearch = false
set.incsearch = true
set.ignorecase = true
set.smartcase = true

set.splitbelow = true
set.splitright = true
set.wrap = false
set.scrolloff = 8
set.fileencoding = 'utf-8'
set.termguicolors = true
set.signcolumn = "yes"

set.cursorline = true
set.hidden = true

set.nu = true
vim.wo.relativenumber = true
set.swapfile = false
set.backup = false
set.undodir = os.getenv("HOME") .. "/.vim/undodir"
set.undofile = true

set.incsearch = true

vim.g.lf_command_override = 'lf -command "set hidden"'
