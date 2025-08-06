require("mason").setup()
-- require("mason-lspconfig").setup({
	-- 	ensure_installed = {
		-- 		"lua_ls",
		-- 		"pyright",
		-- 		"prismals",
		-- 		"basedpyright",
		-- 		"gopls",
		-- 		"awk_ls",
		-- 		"bashls",
		-- 	},
		-- 	automatic_enabled = false,
		-- 	handlers = {},
		-- 	})
		--
		-- -- Настройка LSP серверов
local lspconfig = require('lspconfig')

-- Явная настройка gopls с полным контролем параметров
require('lspconfig').gopls.setup({
	cmd = {"gopls", "serve"},
	filetypes = {"go", "gomod", "gowork", "gotmpl"},
	root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
	settings = {
		gopls = {
			-- Настройки диагностики (важная часть!)
			diagnosticsDelay = "500ms",
			diagnosticsTrigger = "Edit",  -- Проверка при изменениях И сохранении

			-- Анализ кода
			analyses = {
				loopvar = true,         -- Выявляет переменные цикла, которые могут вызывать проблемы
				unusedparams = true,    -- Показывает неиспользуемые параметры функций
				unusedwrite = true,     -- Обнаруживает "холостое" присваивание переменным
				useany = true,          -- Предупреждает о неявном использовании any
				shadow = true,          -- Обнаруживает затенение переменных
				cgocall = true,
				CstyleLoops = true,
			},

			-- Подсказки (hints)
			hints = {
				assignVariableTypes = true,     -- Подсказывает типы при объявлении переменных
				compositeLiteralFields = true,  -- Показывает поля структур
				constantValues = true,         -- Отображает значения констант
				functionTypeParameters = true, -- Подсказывает параметры типов функций
				rangeVariableTypes = true,     -- Подсказывает типы в range-циклах
				parameterNames = true,        -- Показывает имена параметров при вызове
				convertRange = true,
			},

			-- CodeLenses (интерактивные действия)
			codelenses = {
				gc_details = true,       -- Детали сборки мусора
				generate = true,         -- Генерация кода
				regenerate_cgo = true,   -- Регенерация CGO
				test = true,            -- Управление тестами
				tidy = true,            -- go mod tidy
				upgrade_dependency = true, -- Обновление зависимостей
				vendor = true           -- Работа с vendor
			},

			-- Дополнительные настройки
			completeUnimported = true,  -- Автодополнение неимпортированных пакетов
			gofumpt = true,            -- Строгий форматтер
			staticcheck = true,       -- Расширенный анализ кода
			usePlaceholders = true,   -- Заполнители при автодополнении
			semanticTokens = true,    -- Расширенная подсветка синтаксиса

			-- Настройки для работы с модулями
			buildFlags = {"-tags=tag1,tag2"},
			["local"] = "local/trash",

			-- Настройки поиска
			matcher = "Fuzzy",
			symbolMatcher = "FastFuzzy",
		}
	},
	on_attach = function(client, bufnr)
		-- Здесь можно добавить кастомные keybindings для LSP
		-- Например:
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer = bufnr})
	end
})

-- Отключаем стандартные биндинги go.nvim
require('go').setup({
	lsp_cfg = false,  -- Полностью отключаем LSP-конфиг go.nvim
	lsp_keymaps = false, -- Отключаем все keybindings из go.nvim
	-- Остальные настройки go.nvim...
})
