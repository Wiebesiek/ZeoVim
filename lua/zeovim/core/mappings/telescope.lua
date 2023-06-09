local builtin = function()
	return require('telescope.builtin')
end
local set = vim.keymap.set

---------------
-- TELESCOPE --
---------------
set('n', '<leader>gb', function() builtin().git_branches() end, { desc = "Git branches"})
set('n', '<leader>gc', function() builtin().git_commits() end, { desc = "Git commits"})
set('n', '<leader>gt', function() builtin().git_status() end, { desc = "Git status"})
set('n', '<leader>ff', function() builtin().find_files() end, { desc = "Find files"})
set('n', '<leader>fg', function() builtin().live_grep() end, {desc = "Live grep"})
set('n', '<leader>fb', function() builtin().buffers() end, { desc = "Buffers"})
set('n', '<leader>fh', function() builtin().help_tags() end, { desc = "Help tags"})
set('n', '<leader>fd', function() builtin().diagnostics() end, { desc = "Help tags"})
set('n', "<leader>fw",
	function()
		builtin().live_grep {
			additional_args = function(args)
				return vim.list_extend(args, { "--hidden", "--no-ignore" })
			end,
		}
	end,
	{ desc = "Live Grep --hidden --no-ignore" }
)
set('n', '<leader>f<CR>', function() builtin().resume() end, { desc = "Resume Last Picker"})
