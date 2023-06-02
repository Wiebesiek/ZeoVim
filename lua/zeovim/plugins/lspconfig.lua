return {
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		cmd = {
			"Mason",
			"MasonInstall",
			"MasonUninstall",
			"MasonUninstallAll",
			"MasonLog",
		},
		opts = {}
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = true,
		opts = {
			ensure_installed = { "lua_ls", "omnisharp", "tsserver", "volar", "pylsp" }
		},
		dependencies = {
			"williamboman/mason.nvim"
		},
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		opts = {
			ensure_installed = { "python", "coreclr", "node2", "js", "chrome" }
		},
	},
	{
		"jay-babu/mason-null-ls.nvim",
		lazy = true,
		opts = {
			ensure_installed = { "prettierd", "csharpier" }
		},
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "LspInstall", "LspUninstall" },
		dependencies = {
			{
				"folke/neodev.nvim",
				event = "LspAttach",
				config = function()
					require("neodev").setup {
						library = {
							enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
							-- these settings will be used for your Neovim config directory
							runtime = true, -- runtime path
							types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
							plugins = true, -- installed opt or start plugins in packpath
							-- you can also specify the list of plugins to make available as a workspace library
							-- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
						},
						setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
						-- With lspconfig, Neodev will automatically setup your lua-language-server
						-- If you disable this, then you have to set {before_init=require("neodev.lsp").before_init}
						-- in your lsp start options
						lspconfig = false,
						-- much faster, but needs a recent built of lua-language-server
						-- needs lua-language-server >= 3.6.0
						pathStrict = true,
					}
				end,
			},
			{
				"williamboman/mason-lspconfig.nvim",
			}
		},
		config = function()
			require("zeovim.config.omni")
			require("zeovim.config.lua_ls")
		end
	},
}
