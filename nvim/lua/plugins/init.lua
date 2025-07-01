vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use {
      'mason-org/mason.nvim',
      config = function()
		  require('plugins.mason')
	  end
  }
  use {'mason-org/mason-lspconfig.nvim',
       config = function()
		   require('plugins.mason-lspconfig')
	   end
    }
  use 'mfussenegger/nvim-lsp-compl'
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugink
  use { "catppuccin/nvim",
  as = "catppuccin",
  config = function()
	  require('plugins.colorscheme')
  end
  } --colorscheme
  use {
  'nvim-lualine/lualine.nvim',
  requires = { 'nvim-tree/nvim-web-devicons', opt = true },
  config = function()
      require('plugins.lualine')
  end
  }
  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
-- or                            , branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} },
  config = function()
      require('plugins.telescope')
  end
  }
  use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    config = function()
    	require('plugins.treesitter')
    end
  }
  require('plugins.cmp')
  use 'rafamadriz/friendly-snippets'
  use {
    'windwp/nvim-autopairs',
    config = function()
      require("nvim-autopairs").setup()
    end
  }
end)

