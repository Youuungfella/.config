require('nvim-treesitter').setup {
	highlight = { enable = true },
	auto_install = true,
	ensure_installed = { "lua", "go", "python", "vimdoc", "vim", "markdown" }
}
-- Autocommand to start highlightning
vim.api.nvim_create_autocmd('FileType', {
	pattern = { "lua", "go", "python", "vimdoc", "vim", "markdown" },
	callback = function() vim.treesitter.start() end,
})
