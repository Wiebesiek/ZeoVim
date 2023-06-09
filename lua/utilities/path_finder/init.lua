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

local function dotnet_build_project()
	local default_path = vim.fn.getcwd() .. '/'
	if dotnet_last_proj_path ~= nil then
		default_path = dotnet_last_proj_path
	end

	if project_found then
		print('Found project in config. Project file path is ' .. dotnet_last_proj_path)
		return
	end

	local path = vim.fn.input('Path to your *proj file', default_path, 'file')
	dotnet_last_proj_path = path
	local cmd = 'dotnet build -c Debug ' .. path .. ' > /dev/null'
	print('')
	print('Cmd to execute: ' .. cmd)
	local f = os.execute(cmd)
	if f == 0 then
		print('\nBuild: ✔️ ')
	else
		print('\nBuild: ❌ (code: ' .. f .. ')')
	end
end

local function dotnet_get_dll_path()
	local request = function()
		return vim.fn.input('Path to dll ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
	end

	if dotnet_last_dll_path == nil then
		dotnet_last_dll_path = request()
		print('Dll path: ' .. dotnet_last_dll_path)
	else
		if project_found == false and vim.fn.confirm('Do you want to change the path to dll?\n' .. dotnet_last_dll_path, '&yes\n&no', 2) == 1 then
			print('project_found: ' .. tostring(project_found))
			dotnet_last_dll_path = request()
			print('Dll path: ' .. dotnet_last_dll_path)
		end
	end

	return dotnet_last_dll_path
end

-- Recursively search up the directory tree
local function search_up(project_root, path, pattern_func)
	local parent = vim.fn.fnamemodify(path, ':h')
	-- the parent of 'C:/' is 'C:/'
	if parent == path then
		return project_root
	end
	local parent_root = pattern_func(parent)
	-- returns nil when no root is found
	if parent_root == nil then
		return project_root
	end
	return search_up(parent_root, parent, pattern_func)
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
	return search_up(nil, path, root_pattern('*.sln'))
end

-- Entry point for dap
function M.GetDllPath()
	if vim.fn.confirm('Should I recompile first?', '&yes\n&no', 2) == 1 then
		dotnet_build_project()
	end
	return dotnet_get_dll_path()
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
