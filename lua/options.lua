vim.g.mapleader = " "
vim.o.shiftwidth = 2
vim.o.swapfile = false
vim.o.tabstop = 2
vim.o.hidden = true
vim.o.ignorecase = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.scrolloff = 8
vim.wo.wrap = false
vim.opt.termguicolors = true

vim.o.foldcolumn = '0' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
-- disabled for nvim-tree (see docs)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

