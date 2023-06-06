local M = {}

local dotnet_last_proj_path = nil
local dotnet_last_dll_path = nil
local dotnet_debug_cwd = nil
local project_found = false

-- Check to see if path is a part of the config.projects, if so set last_proj_path and last_dll_path
local function GetStaticValues(path)
	local projects = M.config.projects
	for _, project in ipairs(projects) do
		if project.base_path and string.find(path, project.base_path) then
			-- TODO: nil check
			dotnet_last_proj_path = project.dotnet_proj_file
			dotnet_last_dll_path = project.dotnet_dll_path
			dotnet_debug_cwd = project.dotnet_debug_cwd
			project_found = true
			return true
		end
	end
	return false
end

local function dotnet_build_project()
	local default_path = vim.fn.getcwd() .. '/'
	if dotnet_last_proj_path ~= nil then
		default_path = dotnet_last_proj_path
	end

	-- Early exit if we can find the project in the config
	if GetStaticValues(vim.fs.normalize(default_path)) then
		print('Found project in config, using last_proj_path: ' .. dotnet_last_proj_path)
		return
	end

	local path = vim.fn.input('Path to your *proj file', default_path, 'file')
	dotnet_last_proj_path = path
	-- TODO: Need to figure out how to temporarily change the cwd
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

function M.GetDebugCwd()
	print("Calling GetDebugCwd")
	if GetStaticValues(vim.fs.normalize(vim.fn.getcwd() .. '/'))
	then
		return dotnet_debug_cwd
	end
end

return M
