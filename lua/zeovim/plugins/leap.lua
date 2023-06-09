return {
	"ggandor/leap.nvim",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"tpope/vim-repeat"
	},
	config = function ()
		require('leap').add_default_mappings()
		require('leap').opts.safe_labels = {}
	end
}
