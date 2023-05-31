local root_pattern = require('lspconfig.util').root_pattern
local M = {}
M.dotnet_last_proj_path = nil
M.dotnet_last_dll_path = nil

local function dotnet_build_project()
	local default_path = vim.fn.getcwd() .. '/'
	if M.dotnet_last_proj_path ~= nil then
		default_path = M.dotnet_last_proj_path
	end
	local path = vim.fn.input('Path to your *proj file', default_path, 'file')
	M.dotnet_last_proj_path = path
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
		return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
	end

	if M.dotnet_last_dll_path == nil then
		M.dotnet_last_dll_path = request()
	else
		if vim.fn.confirm('Do you want to change the path to dll?\n' .. M.dotnet_last_dll_path, '&yes\n&no', 2) == 1 then
			M.dotnet_last_dll_path = request()
		end
	end

	print('Dll path: ' .. M.dotnet_last_dll_path)
	return M.dotnet_last_dll_path
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


-- TODO: How to find the project that houses the .dll?
-- git ls-files **/launchSettings.json
-- This could be used to find the project name as it will be <project_name>/properties/launchSettings.json
-- Then you would need to use something like `fd --no-ignore <project_name>.dll` to find the path.
-- This would probably still have issues (for instance, there could be .net5 and .net6 folders in the debug), but will work for 95% of projects.
-- ^ This will work as long as you only proceed if you successfully find a single .dll.
-- In the event you don't, maybe return nil and use telescope.

--[[
The standard way of obtaining the root directory does not work well for nested projects
in the dotnet ecosystem. This function will search up the directory tree.
--]]
M.config = {
	default_lsp_root = {"outerMostSln","csProj"}
}
function M.setup(opts)
    if opts ~= nil then
      M.config = vim.tbl_deep_extend("force", M.config, opts)
    end
end
function M.OuterMostSln(path)
	return search_up(nil, path, root_pattern('*.sln'))
end

function M.GetDllPath()
	if vim.fn.confirm('Should I recompile first?', '&yes\n&no', 2) == 1 then
		dotnet_build_project()
	end
	return dotnet_get_dll_path()
end

function M.GetNetCoreDbgPath()
	return vim.fs.normalize(vim.fn.stdpath('data') .. '/mason/packages/netcoredbg/netcoredbg/netcoredbg.exe')
end
return M
