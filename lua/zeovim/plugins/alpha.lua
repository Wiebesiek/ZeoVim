return {
	'goolord/alpha-nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	event = { 'VimEnter' },
	config = function()
		require("zeovim.config.alpha")
	end
}
