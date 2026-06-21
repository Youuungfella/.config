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
})
