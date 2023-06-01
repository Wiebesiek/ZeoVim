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
		lazy = true,
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
		config = function()
			require("zeovim.config.lua_ls")
			require("zeovim.config.omni")
		end
	},
}
