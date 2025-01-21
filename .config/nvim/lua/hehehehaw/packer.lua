
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

return require('lazy').setup({

	{
  		'nvim-telescope/telescope.nvim', tag = '0.1.5',
		-- or                            , branch = '0.1.x',
		dependencies = { {'nvim-lua/plenary.nvim'} }
	},

    --[[
	use({
		"neanias/everforest-nvim",
  		-- Optional; default configuration will be used if setup isn't called.
  		config = function()
    			require("everforest").setup()
  		end,
	})
    ]]

    "lifepillar/vim-colortemplate",
    "aktersnurra/no-clown-fiesta.nvim",
    -- "RRethy/base16-nvim",

	{
  		'nvim-lualine/lualine.nvim',
  		dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
	},

	"f-person/git-blame.nvim",

	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/playground",

	"ThePrimeagen/harpoon",
	"mbbill/undotree",
	"tpope/vim-fugitive",


	{
  		'VonHeikemen/lsp-zero.nvim',
  		branch = 'v3.x',
  		dependencies = {
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
    },

    'christoomey/vim-tmux-navigator',

    'ptzz/lf.vim',
    'voldikss/vim-floaterm',
    {'nyoom-engineering/oxocarbon.nvim'},
    {"ntk148v/komau.vim"},
    'RRethy/base16-nvim',
    "EdenEast/nightfox.nvim",
    "ayu-theme/ayu-vim",
    'Yazeed1s/minimal.nvim',
    "preservim/vim-colors-pencil",
    "p00f/alabaster.nvim",
    "habamax/vim-habamax",
    "kxzk/skull-vim",

})
