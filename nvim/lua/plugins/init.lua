return require('packer').startup(function(use)
  -- Packer
  use 'wbthomason/packer.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use {
	  'mason-org/mason.nvim',
	  config = function()
		  require('mason')
	  end
  }
  use {
    'mason-org/mason-lspconfig.nvim',
    after = 'mason.nvim',
    config = function()
      require('plugins.mason-lspconfig')

    end
  }
  use 'mfussenegger/nvim-lsp-compl'

  -- Autocompletion
  use {
	  'hrsh7th/nvim-cmp',
	  requires = {
		  'hrsh7th/cmp-nvim-lsp',
		  'hrsh7th/cmp-path',
		  'hrsh7th/cmp-buffer',
		  'hrsh7th/cmp-cmdline',
		  'saadparwaiz1/cmp_luasnip',
		  {'L3MON4D3/LuaSnip', run = 'make install_jsregexp'},
		  'rafamadriz/friendly-snippets'
	  },
	  config = function()
		  require('plugins.cmp')
	  end
  }
  -- UI
  use {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require('plugins.colorscheme')
    end
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
      require('plugins.lualine')
    end
  }

  use {
	  "nvim-treesitter/nvim-treesitter-textobjects",
	  after = "nvim-treesitter",
	  requires = "nvim-treesitter/nvim-treesitter",
  }

  -- Navigation
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function()
      require('plugins.telescope')
    end
  }

  -- Syntax
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('plugins.treesitter')
    end
  }
  use {
    'windwp/nvim-autopairs',
    config = function()
      require("nvim-autopairs").setup()
    end
  }

  -- Debugging
  use {
	  'mfussenegger/nvim-dap',
	  config = function()
		  local dap = require('dap')
		  -- Базовая конфигурация (пример для Go)
		  dap.adapters.delve = {
			  type = 'server',
			  port = '${port}',
			  executable = {
				  command = 'dlv',
				  args = {'dap', '-l', '127.0.0.1:${port}'},
			  }
		  }
	  end
  }

  use {
	  'theHamsta/nvim-dap-virtual-text',
	  config = function()
		  require("nvim-dap-virtual-text").setup()
	  end
  }

  use {
	  'leoluz/nvim-dap-go',
	  requires = {'mfussenegger/nvim-dap'},
	  config = function()
		  require('dap-go').setup()
	  end
  }

  use {
	  'rcarriga/nvim-dap-ui',
	  requires = {'mfussenegger/nvim-dap',"nvim-neotest/nvim-nio"},
	  config = function()
		  require('plugins.dap-ui')
	  end
  }

  use 'nvim-neotest/nvim-nio'

  -- Terminal
  use {
	  "akinsho/toggleterm.nvim",
	  tag = '*',
	  config = function()
		  require("plugins.toggleterm")
	  end
  }

  -- Plugin for GO
  use {
	  'ray-x/go.nvim',
	  config = function()
		  require("plugins.go")
	  end
  }
  use 'ray-x/guihua.lua'
end)
