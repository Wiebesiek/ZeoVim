return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {
	},
	config = function()
		local wk = require("which-key")
		wk.register({
				g = {
					name = "Telescope Git"
				},
				h = {
					name = "GitSigns"
				},
				t = {
					name = "Test Suite"
				},
			},
			{
				prefix = "<leader>",
			}
		)
	end
}
