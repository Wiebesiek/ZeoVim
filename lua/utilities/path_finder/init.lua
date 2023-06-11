-- Dependencies: require('lspconfig.util').root_pattern	
local utils = require('utilities.path_finder.utils')
local M = {}

local dotnet_last_proj_path = nil
local dotnet_last_dll_path = nil
local dotnet_debug_cwd = nil
local project_found = false

local function init_path_values(path)
	local static_values = utils.GetProjConfig(path, M.config)
	if static_values.project_found then
		dotnet_last_proj_path = static_values.dotnet_last_proj_path
		dotnet_last_dll_path = static_values.dotnet_last_dll_path
		dotnet_debug_cwd = static_values.dotnet_debug_cwd
		project_found = true
		print('Found project in config. Project file path is ' .. dotnet_last_proj_path)
	else
		project_found = false
		dotnet_last_proj_path = nil
		dotnet_last_dll_path = nil
		dotnet_debug_cwd = nil
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

-- nil returned when no project config
function M.GetDebugCwd()
	init_path_values(vim.fs.normalize(vim.fn.getcwd() .. '/'))
	if project_found
	then
		return dotnet_debug_cwd
	end
end

-- nil returned when no project config, this allows default cwd to be used
-- TODO: this is functional in nature, needs M.GetDllPath to be changed
function M.GetDebugCwd2()
	local proj_config = utils.GetProjConfig(vim.fs.normalize(vim.fn.getcwd()), M.config)
	return proj_config.dotnet_debug_cwd
end

return M
