local time = os.date("%H:%M")
local v = vim.version()
local version = "version " .. v.major .. "." .. v.minor .. "." .. v.patch
return {
	'goolord/alpha-nvim',
	dependenices = { 'nvim-tree/nvim-web-devicons' },
	event = { 'VimEnter' },
	config = function()
		local alpha = require 'alpha'
		local dashboard = require 'alpha.themes.dashboard'
		dashboard.section.header.val = {
			[[ ______           _   _ _            ]],
			[[|___  /          | | | (_)           ]],
			[[   / /  ___  ___ | | | |_ _ __ ___   ]],
			[[  / /  / _ \/ _ \| | | | | '_ ` _ \  ]],
			[[./ /__|  __| (_) \ \_/ | | | | | | | ]],
			[[\_____/\___|\___/ \___/|_|_| |_| |_| ]],
			[[   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣾⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
			[[   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣴⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀]],
			[[   ⠀⠀⠀⠀⠀⠀⢀⣤⣶⣶⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⠀⠀⠀⠀⠀⠀⠀⠀]],
			[[   ⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀]],
			[[   ⠀⠀⠀⠀⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠋⠀⠀⠀⠀⠀⠀⠀⠀]],
			[[   ⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
			[[   ⠀⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
			[[   ⠀⠀⣾⣿⣿⣿⣿⠛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
			[[   ⠀⢰⣿⣿⣿⣿⣿⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣄⠀⠀⠀⠀⠀⠀⠀⠀]],
			[[   ⠀⣾⣿⣿⣿⡟⠁⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀]],
			[[   ⢀⣿⣿⣿⡟⠀⠀⣸⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⠙⠛⠿⣿⣿⣿⣷⡄⠀⠀⠀⠀]],
			[[   ⢸⣿⣿⣿⣷⡄⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠀⠀⠈⢻⣿⣿⣿⣦⠀⠀⠀]],
			[[   ⠘⣿⣿⣿⠙⠇⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⢿⠉⢹⣿⡇⠀⠀]],
			[[   ⠀⠀⠙⠛⠛⠂⠀⠀⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡄⠀⠀⠀⠸⠛⠁⠀⠀]],
			[[   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⡿⢿⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⠀⠀]],
			[[   ⠀⠀⠀⠀⠀⠀⠀⣠⣤⣶⣿⣿⣿⣿⣿⠃⠀⠈⢻⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀]],
			[[   ⠀⠀⠀⠀⠀⢠⣾⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⢸⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀]],
			[[   ⠀⠀⠀⠀⣠⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀]],
			[[   ⠀⢀⣤⣾⣿⣿⣿⣿⡿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⢿⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀]],
			[[   ⣴⣿⣿⣿⣿⣿⠟⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⣿⣿⣿⣧⣤⣤⣀⣠⣤]],
			[[   ⠻⣿⣿⣿⣿⣿⣿⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⠏]],
			[[   ⠀⠀⠀⠀⠙⠛⠿⠿⠛⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⣿⣿⠿⠟⠛⠛⠉⠀]],
		}
		dashboard.section.buttons.val = {
			dashboard.button("spc f f", "  Find File", ":Telescope find_files<CR>"),
			dashboard.button("spc f g", "  Grep It", ":Telescope live_grep<CR>"),
			dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("q", "  Quit ZeoVim", ":qa<CR>"),
		}
		dashboard.config.opts.noautocmd = true

		dashboard.section.footer.val = {
			"     " .. time .. " ",
			version,
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
		}
		vim.cmd [[autocmd User AlphaReady echo 'ready']]

		alpha.setup(dashboard.config)
	end
}
