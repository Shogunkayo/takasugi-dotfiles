vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(user)
	use 'wbthomason/packer.nvim'

	use {
  		'nvim-telescope/telescope.nvim', tag = '0.1.5',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use({
		"neanias/everforest-nvim",
  		-- Optional; default configuration will be used if setup isn't called.
  		config = function()
    			require("everforest").setup()
  		end,
	})
	
	use {
  		'nvim-lualine/lualine.nvim',
  		requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	}

	use "f-person/git-blame.nvim"

	use "nvim-treesitter/nvim-treesitter"
	use "nvim-treesitter/playground"

	use "ThePrimeagen/harpoon"
	use "mbbill/undotree"
	use "tpope/vim-fugitive"


	use {
  		'VonHeikemen/lsp-zero.nvim',
  		branch = 'v3.x',
  		requires = {
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},

			-- LSP Support		    
			{'neovim/nvim-lspconfig'},
			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'L3MON4D3/LuaSnip'},
			{'hrsh7th/cmp-buffer'},
			{'hrsh7th/cmp-path'},
			{'saadparwaiz1/cmp_luasnip'},
			{'hrsh7th/cmp-nvim-lua'},
			{'rafamadriz/friendly-snippets'}
		}
    }

    use 'christoomey/vim-tmux-navigator'
    
    use 'ptzz/lf.vim'
    use 'voldikss/vim-floaterm'
    
end)
