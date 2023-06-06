local neotest = function()
	return require('neotest')
end

local set = vim.keymap.set

-----------------
-- Test Runner --
-----------------
local neotest_dap = function()
	if vim.bo.filetype == "cs" then
		neotest().run.run({ strategy = require("neotest-dotnet.strategies.netcoredbg"), is_custom_dotnet_debug = true })
	else
		neotest().run.run({ strategy = "dap" })
	end
end

set('n', '<leader>td', neotest_dap, { desc = "Debug test under cursor" })
set('n', '<leader>tn', function() neotest().run.run() end, { desc = "Run nearest test" })
set('n', '<leader>ts', function() neotest().run.run({ suite = true }) end, { desc = "Run test suite" })
set('n', '<leader>tt', function() neotest().output_panel.toggle() end, { desc = "Toggle test output" })
set('n', '<leader>tw', function() neotest().output.open({ enter = true }) end, { desc = "Open test output" })
set('n', '<leader>tf', function() neotest().run.run(vim.fn.expand("%")) end, { desc = "Run unit tests in current file" })
