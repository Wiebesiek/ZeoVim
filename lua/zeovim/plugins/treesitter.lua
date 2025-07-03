return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	cmd = {
		"TSBufDisable",
		"TSBufEnable",
		"TSBufToggle",
		"TSDisable",
		"TSEnable",
		"TSToggle",
		"TSInstall",
		"TSInstallInfo",
		"TSInstallSync",
		"TSModuleInfo",
		"TSUninstall",
		"TSUpdate",
		"TSUpdateSync",
	},
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"c",
			"c_sharp",
			"cpp",
			"css",
			"html",
			"javascript",
			"json",
			"lua",
			"norg",
			"python",
			"sql",
			"typescript",
			"yaml",
			"vue",
		},
		indent = { enable = true },
		highlight = { enable = true }
	},
	config = function (_, opts)
		require('nvim-treesitter.install').compilers = { "gcc", "zig" }
		require("nvim-treesitter.configs").setup(opts)
	end
}
