require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {},
})

-- Настройка LSP серверов
local lspconfig = require('lspconfig')

-- Базовые настройки для всех серверов
-- local default_setup = function(server)
	-- lspconfig[server].setup({})
-- end

-- Специальные настройки для конкретных серверов
local servers = {
	gopls = {
		settings = {
			gopls = {
				analyses = {
					loopvar = true,
				},
				hints = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
					constantValues = true,
					functionTypeParameters = true,
					rangeVariableTypes = true,
				},
			},
		},
	},
	-- Можно добавить другие серверы с особыми настройками здесь
}

-- Применяем настройки
vim.lsp.config("gopls", {settings = {
	gopls = {
		analyses = {
			loopvar = true,
		},
		hints = {
			assignVariableTypes = true,
			compositeLiteralFields = true,
			constantValues = true,
			functionTypeParameters = true,
			rangeVariableTypes = true,
		},
	},
},
})
