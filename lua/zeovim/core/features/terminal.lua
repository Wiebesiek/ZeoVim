local current_file_dir = function()
	return vim.fs.normalize(vim.fn.expand('%:p:h'))
end

local csproj_dir = function()
	local root_pattern = require('lspconfig.util').root_pattern
	local path = vim.fs.normalize(vim.fn.expand('%:p'))
	return root_pattern("*.csproj")(path)
end

local Terminal = require('toggleterm.terminal').Terminal

local ProjectTerm = Terminal:new({
	cmd = "pwsh",
	close_on_exit = true,
	direction = "float",
	float_opts = { border = "single" },
})

function ProjTerm_Toggle()
	ProjectTerm.dir = csproj_dir() or current_file_dir()
	ProjectTerm:toggle()
end

vim.api.nvim_create_user_command('ProjTermToggle', function() ProjTerm_Toggle() end, {
	desc = "Toggle float terminal for current project.",
})
