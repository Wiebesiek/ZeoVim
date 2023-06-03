return {
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		dependencies = {
			"jay-babu/mason-nvim-dap.nvim",
			"rcarriga/nvim-dap-ui",
		},
		config = function()
			require("zeovim.config.dap")
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		lazy = true
	}
}
