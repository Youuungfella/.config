vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git", "clone", "--filter=blob:none", "https://github.com",
		"--branch=stable", lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Mason
	{
		'williamboman/mason.nvim', -- исправлено имя организации (williamboman)
		config = function()
			require('plugins.mason')
		end
	},

	-- Autocompletion
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-cmdline',
			'saadparwaiz1/cmp_luasnip',
			{ 'L3MON4D3/LuaSnip', build = 'make install_jsregexp' },
			'rafamadriz/friendly-snippets'
		},
		config = function()
			require('plugins.cmp')
		end
	},

	-- UI
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require('plugins.colorscheme')
		end
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require('plugins.lualine')
		end
	},

	-- Syntax & Treesitter
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		branch = 'main', -- Важно для Neovim 0.12
		config = function()
			require('plugins.treesitter')
		end
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require('plugins.tsobjects')
		end
	},
	{
		'windwp/nvim-autopairs',
		config = function()
			require("nvim-autopairs").setup()
		end
	},

	-- Navigation
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		priority = 1000, -- Загружаем в приоритете
		config = function()
			-- Принудительный патч прямо перед загрузкой настроек
			local ts = vim.treesitter
			if ts.language and ts.language.get_lang then
				ts.language.ft_to_lang = ts.language.get_lang
			end
			require('plugins.telescope')
		end
	},


	-- Debugging
	{
		'mfussenegger/nvim-dap',
		config = function()
			local dap = require('dap')
			dap.adapters.delve = {
				type = 'server',
				port = '${port}',
				executable = {
					command = 'dlv',
					args = { 'dap', '-l', '127.0.0.1:${port}' },
				}
			}
		end
	},
	{
		'theHamsta/nvim-dap-virtual-text',
		config = function()
			require("nvim-dap-virtual-text").setup()
		end
	},
	{
		'leoluz/nvim-dap-go',
		dependencies = { 'mfussenegger/nvim-dap' },
		config = function()
			require('dap-go').setup()
		end
	},
	{
		'rcarriga/nvim-dap-ui',
		dependencies = { 'mfussenegger/nvim-dap', "nvim-neotest/nvim-nio" },
		config = function()
			require('plugins.dap-ui')
		end
	},
	{ 'nvim-neotest/nvim-nio' },

	-- Terminal
	{
		"akinsho/toggleterm.nvim",
		version = '*',
		config = function()
			require("plugins.toggleterm")
		end
	},

	--Yazy explorer

	{
		"mikavilpas/yazi.nvim",
		version = "*", -- use the latest stable version
		event = "VeryLazy",
		dependencies = {
			{ "nvim-lua/plenary.nvim", lazy = true },
		},
		keys = {
			{
				"<leader>-",
				mode = { "n", "v" },
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				"<leader>cw",
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
			{
				"<c-up>",
				"<cmd>Yazi toggle<cr>",
				desc = "Resume the last yazi session",
			},
		},
	},

	-- Plugin for GO
	{
		'ray-x/go.nvim',
		dependencies = { 'ray-x/guihua.lua', 'neovim/nvim-lspconfig', 'nvim-treesitter/nvim-treesitter' },
		config = function()
			require("plugins.go")
		end,
		event = { "CmdlineEnter" },
		ft = { "go", 'gomod' },
	},

	-- Lazygit
	{
		"kdheepak/lazygit.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	-- Avante AI plugin
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false,
		build = "make",
		opts = {
			-- Указываем использовать ollama, которая теперь лежит в таблице providers
			__inherited_from = "openai",
			instructions_file = "avante.md",
			provider = "ollama",
			ft = { "markdown", "Avante" },
			hints = { enabled = true },
			windows = {
				position = "right",
				width = 40,
			},
			-- Новая единая структура согласно гайду миграции
			providers = {
				ollama = {
					endpoint = "http://127.0.0.1:11434",
					model = "deepseek-coder-v2:16b", --qwen2.5-coder:7b
					timeout = 30000,
					extra_request_body = {
						options = {
							num_ctx = 32768,
							temperature = 0.2,
							keep_alive = "5m"
						},
					},
				},
			},
			behaviour = {
				auto_suggestions = false,
				support_paste_from_clipboard = false,
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-mini/mini.pick",  -- for file_selector provider mini.pick
			"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
			"hrsh7th/nvim-cmp",     -- autocompletion for avante commands and mentions
			"ibhagwan/fzf-lua",     -- for file_selector provider fzf
			"stevearc/dressing.nvim", -- for input provider dressing
			"folke/snacks.nvim",    -- for input provider snacks
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
					},
				},
			},
			{
				'MeanderingProgrammer/render-markdown.nvim',
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},
	-- {
	-- 	"olimorris/codecompanion.nvim",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"hrsh7th/nvim-cmp", -- Опционально для автодополнения
	-- 	},
	-- 	config = function()
	-- 		require("codecompanion").setup({
	-- 			strategies = {
	-- 				chat = { adapter = "ollama" },
	-- 				inline = { adapter = "ollama" },
	-- 			},
	-- 			adapters = {
	-- 				ollama = function()
	-- 					return require("codecompanion.adapters").extend("ollama", {
	-- 						schema = {
	-- 							model = { default = "qwen2.5-coder:7b" },
	-- 							num_ctx = { default = 16384 },
	-- 						},
	-- 					})
	-- 				end,
	-- 			},
	-- 		})
	-- 	end,
	-- }
	{
		'akinsho/bufferline.nvim',
		version = "*",
		dependencies = 'nvim-tree/nvim-web-devicons',
		config = function()
			require("bufferline").setup {
				highlights = require("catppuccin.special.bufferline").get_theme()
			}
		end
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
		config = function()
			require("ibl").setup()
		end,
	},
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		}
	},
	{
		"sphamba/smear-cursor.nvim",
		opts = {
			stiffness = 0.8,
			trailing_stiffness = 0.6,
			damping = 0.95,
		},
	},
	--Translator plugin
	{
		'potamides/pantran.nvim',
		config = function()
			require("plugins.pantran")
		end
	}
})
