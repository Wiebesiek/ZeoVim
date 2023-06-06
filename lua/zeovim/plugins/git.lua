return {
	{
		'tpope/vim-fugitive',
		cmd = { "G", "GcLog", "Gclog", "Git" }
	},
	{
		'lewis6991/gitsigns.nvim',
		event = { "BufReadPost", "BufNewFile" },
		opts = require("zeovim.config.gitsigns")
	},
	{
		-- trialing this
		'TimUntersberger/neogit',
		cmd = { "Neogit" }
	}
}
