vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer
  use 'wbthomason/packer.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use {
	  'mason-org/mason.nvim',
	  config = function()
		  require('mason').setup()
		  ui = {
			  icons = {
				  package_installed = "✓",
				  package_pending = "➜",
				  package_uninstalled = "✗"
			  }
		  }

    end
  }
  use {
    'mason-org/mason-lspconfig.nvim',
    after = 'mason.nvim',
    config = function()
      require('mason-lspconfig').setup()

    end
  }
  use 'mfussenegger/nvim-lsp-compl'

  -- Autocompletion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'
  require('plugins.cmp')

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
    after = 'mason.nvim'
  }
  use {
    'leoluz/nvim-dap-go',
    after = 'nvim-dap',
    config = function()
      require('plugins.dap-go')
    end
  }
  use {
    'rcarriga/nvim-dap-ui',
    requires = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    config = function()
      require('plugins.dap-ui')
    end
  }
end)
