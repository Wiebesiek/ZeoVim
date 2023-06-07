return {
	"akinsho/toggleterm.nvim",
	cmd = "ToggleTerm",
	event = "VimEnter", -- TODO: to do better than this, make projterm toggle a command?
	version = "*",
	opts = {},
	config = function()
		require("zeovim.core.features.terminal")
	end,
}
