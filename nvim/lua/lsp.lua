-- Добавь capabilities для LSP
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Общий on_attach
local on_attach = function(client, bufnr)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Hover' })
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'Go to definition' })
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'Go to declaration' })
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr, desc = 'Go to implementation' })
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Signature help' })
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Code action' })
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = 'Rename' })
	vim.keymap.set('n', '<leader>lf', function()
		vim.lsp.buf.format({ async = true })
	end, { buffer = bufnr, desc = 'Format buffer' })
end

-- Настройки для каждого LSP-сервера (упрощенные)
local lsp_configs = {
	gopls = {
		cmd = { "gopls", "serve" },
		filetypes = { "go", "gomod", "gowork", "gotmpl" },
		settings = {
			gopls = {
				diagnosticsDelay = "500ms",
				diagnosticsTrigger = "Edit",
				analyses = {
					fillswitch = true,
					fillstruct = true,
					loopvar = true,
					unusedparams = true,
					unusedwrite = true,
					useany = true,
					shadow = true,
					cgocall = true,
					CstyleLoops = true,
				},
				hints = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
					constantValues = true,
					functionTypeParameters = true,
					rangeVariableTypes = true,
					parameterNames = true,
					convertRange = true,
				},
				codelenses = {
					gc_details = true,
					generate = true,
					regenerate_cgo = true,
					test = true,
					tidy = true,
					upgrade_dependency = true,
					vendor = true,
				},
				completeUnimported = true,
				gofumpt = true,
				staticcheck = true,
				usePlaceholders = true,
				semanticTokens = true,
				buildFlags = { "-tags=tag1,tag2" },
				["local"] = "local/trash",
				matcher = "Fuzzy",
				symbolMatcher = "FastFuzzy",
			},
		},
		on_attach = on_attach,
		capabilities = capabilities,
	},

	lua_ls = {
		cmd = { "lua-language-server" },
		on_attach = on_attach,
		capabilities = capabilities,
	},

	bashls = {
		cmd = { "bash-language-server", "start" },
		on_attach = on_attach,
		capabilities = capabilities,
	},

	pylsp = {
		cmd = { "pylsp" },
		on_attach = on_attach,
		capabilities = capabilities,
	},

	tsserver = {
		cmd = { "typescript-language-server", "--stdio" },
		on_attach = on_attach,
		capabilities = capabilities,
	},
}

-- МАТИЧЕСКИЙ ЗАПУСК LSP С ON_ATTACH
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "lua", "go", "python", "sh", "bash", "javascript", "typescript" },
	callback = function(args)
		local bufnr = args.buf
		local filetype = vim.bo[bufnr].filetype

		local server_map = {
			lua = "lua_ls",
			go = "gopls",
			python = "pylsp",
			sh = "bashls",
			bash = "bashls",
			javascript = "tsserver",
			typescript = "tsserver",
		}

		local server_name = server_map[filetype]
		if server_name and lsp_configs[server_name] then
			-- Находим корневую директорию
			local root_dir = vim.fs.dirname(vim.fs.find({ '.git' }, { upward = true })[1]) or vim.loop.cwd()

			-- Запускаем LSP с on_attach И capabilities
			vim.lsp.start(vim.tbl_extend('force', lsp_configs[server_name], {
				name = server_name,
				root_dir = root_dir,
				on_attach = on_attach,
				capabilities = capabilities,
			}))
		end
	end,
})

-- Глобальный обработчик LspAttach на всякий случай
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client.name ~= "null-ls" then
			on_attach(client, bufnr)
		end
	end,
})
