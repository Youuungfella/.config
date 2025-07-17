require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"pyright",
		"prismals",
		"basedpyright",
		"gopls",
		"awk_ls",
		"bashls",
	},
})

-- Настройка LSP серверов
local lspconfig = require('lspconfig')

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
