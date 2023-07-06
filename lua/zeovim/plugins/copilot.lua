return {
	"github/copilot.vim",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		vim.g.copilot_filetypes = {
			["*"] = true,
			["c"] = false,
			["cpp"] = false,
		}
	end,
}
