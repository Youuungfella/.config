local pantran = require("pantran")

pantran.setup({
	-- Движок по умолчанию (google, yandex, deepl, argos, apertium)
	default_engine = "google",
	engines = {
		google = {
			fallback = { default_target = "ru" } -- всегда переводить на русский
		}
	},
	ui = {
		width_percentage = 0.8,
		height_percentage = 0.8,
	}
})

-- Горячие клавиши 
local opts = { noremap = true, silent = true, expr = true }

-- 1. Обычный режим: <Leader>tr + text-object (например, <Leader>trip переведет весь абзац)
vim.keymap.set("n", "<leader>tr", pantran.motion_translate, opts)

-- 2. Обычный режим: <Leader>trr переведет ТЕКУЩУЮ строку целиком
vim.keymap.set("n", "<leader>trr", function() return pantran.motion_translate() .. "_" end, opts)

-- 3. Режим выделения (Visual): выделили предложение и нажали <Leader>tr
vim.keymap.set("x", "<leader>tr", pantran.motion_translate, opts)
