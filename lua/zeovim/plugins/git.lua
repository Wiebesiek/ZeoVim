return {
	{
		'tpope/vim-fugitive',
		enabled = vim.fn.executable "git" == 1,
		cmd = { "G", "GcLog", "Gclog" }
	},
	{
		'lewis6991/gitsigns.nvim',
		enabled = vim.fn.executable "git" == 1,
		event = "User AstroGitFile",
	},
	{
		-- trialing this
		'TimUntersberger/neogit',
		enabled = vim.fn.executable "git" == 1,
		cmd = { "Neogit" }
	}
}
