local utils = require('utilities.path_finder.utils')
local M = {}

function M.OuterMostSln(path)
	local root_pattern = require('lspconfig.util').root_pattern
	return utils.search_up_path(nil, path, root_pattern('*.sln'))
end

function M.GetOmniSharpDll()
	return vim.fs.normalize(vim.fn.stdpath('data') .. '/mason/packages/omnisharp/libexec/OmniSharp.dll')
end

function M.GetLspRootDir(path)
	local root_pattern = require('lspconfig.util').root_pattern
	return M.OuterMostSln(path) or root_pattern("*.csproj")(path)
end

return M
