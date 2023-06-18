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
	uild = ":TSUpdate",
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
			"vue",
		},
		indent = { enable = true },
		highlight = { enable = true }
	},
	config = function (_, opts)
		require('nvim-treesitter.install').compilers = { "zig" }
		require("nvim-treesitter.configs").setup(opts)
	end
}
