-- Dependencies: require('lspconfig.util').root_pattern	
local utils = require('utilities.path_finder.utils')
local M = {}

local dotnet_last_proj_path = nil
local dotnet_last_dll_path = nil
local dotnet_debug_cwd = nil
local project_found = false

local function init_path_values(path)
	local static_values = utils.GetStaticValues(path, M.config)
	if static_values.project_found then
		dotnet_last_proj_path = static_values.dotnet_last_proj_path
		dotnet_last_dll_path = static_values.dotnet_last_dll_path
		dotnet_debug_cwd = static_values.dotnet_debug_cwd
		project_found = true
		print('Found project in config. Project file path is ' .. dotnet_last_proj_path)
	end
end

M.config = {
	default_lsp_root = { "outerMostSln", "csProj" }, -- TODO: currently, not being used
}
function M.setup(opts)
	if opts ~= nil then
		M.config = vim.tbl_deep_extend("force", M.config, opts)
	end
end

function M.OuterMostSln(path)
	local root_pattern = require('lspconfig.util').root_pattern
	return utils.search_up_path(nil, path, root_pattern('*.sln'))
end

-- Entry point for dap
function M.GetDllPath()
	if vim.fn.confirm('Should I recompile first?', '&yes\n&no', 2) == 1 then
		dotnet_last_proj_path = utils.dotnet_build_project(dotnet_last_proj_path, project_found)
	end
	dotnet_last_dll_path = utils.dotnet_get_dll_path(dotnet_last_dll_path, project_found)
	return dotnet_last_dll_path
end

function M.GetNetCoreDbgPath()
	return vim.fs.normalize(vim.fn.stdpath('data') .. '/mason/packages/netcoredbg/netcoredbg/netcoredbg.exe')
end

function M.GetOmniSharpDll()
	return vim.fs.normalize(vim.fn.stdpath('data') .. '/mason/packages/omnisharp/libexec/OmniSharp.dll')
end

function M.GetLspRootDir(path)
	local root_pattern = require('lspconfig.util').root_pattern
	return M.OuterMostSln(path) or root_pattern("*.csproj")(path)
end

function M.GetDebugCwd()
	print("Calling GetDebugCwd")
	init_path_values(vim.fs.normalize(vim.fn.getcwd() .. '/'))
	if project_found
	then
		return dotnet_debug_cwd
	end
end

return M
