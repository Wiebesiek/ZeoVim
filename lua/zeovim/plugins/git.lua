return {
	{
		'tpope/vim-fugitive',
		cmd = { "G", "GcLog", "Gclog" }
	},
	{
		'lewis6991/gitsigns.nvim',
		event = { "BufReadPost", "BufNewFile" },
	},
	{
		-- trialing this
		'TimUntersberger/neogit',
		cmd = { "Neogit" }
	}
}
