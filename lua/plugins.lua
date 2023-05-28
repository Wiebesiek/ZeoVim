local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
	use { 'wbthomason/packer.nvim', lock = true }
	----------
	-- misc --
	----------
	use 'tpope/vim-fugitive' -- This doesn't need locked. Rockstar Status.
	use {
		"windwp/nvim-autopairs",
		config = function() require("nvim-autopairs").setup {} end
	}
	use {
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		lock = true
	}
	use 'folke/zen-mode.nvim'

	use {
		'lewis6991/gitsigns.nvim',
	}
	use {
		'TimUntersberger/neogit'
	}

	-----------------
	-- COLORSCHEME --
	-----------------
	use { 'ellisonleao/gruvbox.nvim', lock = true }
	use { 'folke/tokyonight.nvim', lock = true }

	----------------
	-- COMPLETION --
	----------------
	use { 'L3MON4D3/LuaSnip', lock = true }
	use { 'saadparwaiz1/cmp_luasnip', lock = true }
	use { 'hrsh7th/cmp-nvim-lsp', lock = true }
	use { 'hrsh7th/cmp-buffer', lock = true }
	use { 'hrsh7th/cmp-path', lock = true }
	use { 'hrsh7th/cmp-cmdline', lock = true }
	use { 'hrsh7th/cmp-nvim-lua', lock = true }
	use {
		'hrsh7th/nvim-cmp',
		lock = true,
	}

	------------------
	--  TREESITTER  --
	------------------
	use({
		"nvim-treesitter/nvim-treesitter",
		-- run = ":TSUpdate",
		lock = true
	})

	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	}

	-----------
	-- MASON --
	-----------
	use { 'neovim/nvim-lspconfig',
		lock = true,
	}
	use { "williamboman/mason.nvim",
		requires = {
			"williamboman/mason-lspconfig.nvim"
		},
		lock = true, run = ":MasonUpdate" -- :MasonUpdate updates registry contents
	}

	use {
		"folke/neodev.nvim",
		lock = true
	}
	use { "jose-elias-alvarez/null-ls.nvim",
		lock = true,
	}

	---------------
	-- TELESCOPE --
	---------------
	use {
		'nvim-telescope/telescope.nvim',
		tag = '0.1.x',
		requires = {
			{
				'nvim-lua/plenary.nvim'
			}
		},
	}
	use "nvim-telescope/telescope-ui-select.nvim"

	----------------
	-- DIAGNOSTIC --
	----------------
	use {
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
	}
	use "github/copilot.vim"

	---------
	-- DAP --
	---------
	use {
		"mfussenegger/nvim-dap",
		requires = {
			-- Currently, I need custom configuration that mason-nvim-dap isn't providing.
			-- Leaving here though as the repo is a great resource for looking at how to configure
			-- dap
			-- { "jay-babu/mason-nvim-dap.nvim", lock = false },
			{ "rcarriga/nvim-dap-ui", lock = true }
		},
		lock = true, -- TODO: lock. this. down.
	}

	----------------
	-- unit tests --
	----------------
	use({
		"nvim-neotest/neotest",
		requires = {
			{
				"nvim-lua/plenary.nvim",
				"nvim-treesitter/nvim-treesitter",
			},
		},
		lock = true,
	})
	use "antoinemadec/FixCursorHold.nvim"
	use "Issafalcon/neotest-dotnet"
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)
