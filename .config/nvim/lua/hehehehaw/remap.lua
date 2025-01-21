vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, {desc="Netrw: open filetree"})

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
vim.keymap.set("n", "<leader>a", mark.add_file, {desc="Harpoon: mark file"})
vim.keymap.set("n", "<leader>e", ui.toggle_quick_menu, {desc="Harpoon: open menu"})
vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end, {desc="Harpoon: open mark 1"})
vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end, {desc="Harpoon: open mark 2"})
vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end, {desc="Harpoon: open mark 3"})
vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end, {desc="Harpoon: open mark 4"})

vim.keymap.set("n", "<leader>uu", vim.cmd.UndotreeToggle, {desc="Undotree: open tree"})

vim.keymap.set("n", "<leader>gs", vim.cmd.Git, {desc="VimFugitive: open menu"})

--[[
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>o", builtin.find_files, {})
vim.keymap.set("n", "<leader>gg", builtin.live_grep, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
]]--

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {desc="Nvim: move selection down"})
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv", {desc="Nvim: move selection up"})

vim.keymap.set("n", "<C-d>", "<C-d>zz", {desc="Nvim: scroll down"})
vim.keymap.set("n", "<C-u>", "<C-u>zz", {desc="Nvim: scroll up"})

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>y", "\"+y", {desc="Nvim: yank to system clipboard"})
vim.keymap.set("v", "<leader>y", "\"+y", {desc="Nvim: yank to system clipboard"})

vim.keymap.set("n", "<leader>F", function() vim.lsp.buf.format() end, {desc="LSP: format buffer"})

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {desc="Nvim: find and replace current word"})

vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", {silent = true, desc="Nvim: make file executable"})
vim.keymap.set("n", "<leader>X", "<cmd>!chmod -x %<CR>", {silent = true, desc="Nvim: make file not executable"})
