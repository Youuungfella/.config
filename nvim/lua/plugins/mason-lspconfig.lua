require("mason-lspconfig").setup({
	ensure_installed = { "gopls", "pyright", "bashls", "lua_ls"},
	automatic_installation = true,
})

-- Настройка LSP через mason-lspconfig
require('mason-lspconfig').setup_handlers({
	-- Базовые настройки для всех LSP
	function (server_name)
		require('lspconfig')[server_name].setup({})
	end,
	-- Специальные настройки только для gopls
	gopls = function()
		require('lspconfig').gopls.setup({
			settings = {
				gopls = {
					analyses = {
						loopvar = true,  -- Показывает предупреждения для "неидиоматических" циклов
					},
					hints = {
						assignVariableTypes = true,
						compositeLiteralFields = true,
						constantValues = true,
						functionTypeParameters = true,
						rangeVariableTypes = true,  -- Подсказывает использовать `range` вместо C-style for
					},
				},
			},
		})
	end,
})
