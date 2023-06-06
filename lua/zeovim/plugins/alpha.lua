return {
	'goolord/alpha-nvim',
	dependenices = { 'nvim-tree/nvim-web-devicons' },
	event = { 'VimEnter' },
	config = function()
		require("zeovim.config.alpha")
	end
}
