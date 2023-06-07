local current_file_dir = function()
	return vim.fs.normalize(vim.fn.expand('%:p:h'))
end

local Terminal = require('toggleterm.terminal').Terminal

local NugetTerm = Terminal:new({
	cmd = "pwsh",
	close_on_exit = true,
	direction = "float",
	float_opts = { border = "single" },
})

function ProjTerm_Toggle()
	NugetTerm.dir = current_file_dir()
	NugetTerm:toggle()
end
