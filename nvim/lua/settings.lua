-- Показывать ошибки прямо в коде
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	update_in_insert = false,
})

local tabspaces = 6

vim.opt.tabstop = tabspaces
vim.opt.shiftwidth = tabspaces
vim.opt.softtabstop = tabspaces
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = false
vim.opt.cmdheight = 0
vim.opt.laststatus = 3
vim.opt.splitright = true
vim.opt.termguicolors = true
