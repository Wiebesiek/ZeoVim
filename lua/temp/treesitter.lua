require('nvim-treesitter.configs').setup {
	ensure_installed = {
		"c",
		"c_sharp",
		"css",
		"cpp",
		"html",
		"javascript",
		"json",
		"lua",
		"python",
		"typescript",
		"vue",
	},
	indent = { enable = true },
	highlight = { enable = true }
}
require('nvim-treesitter.install').compilers = { "zig" }
