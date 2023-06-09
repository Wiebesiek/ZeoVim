local M = {}

-- Check to see if path is a part of the config.projects, if so set last_proj_path and last_dll_path
function M.GetStaticValues(path, config)
	local result = {}
	local projects = config.projects
	for _, project in ipairs(projects) do
		if project.base_path and string.find(path, project.base_path) then
			-- TODO: nil check, if even needed.
			result.dotnet_last_proj_path = project.dotnet_proj_file
			result.dotnet_last_dll_path = project.dotnet_dll_path
			result.dotnet_debug_cwd = project.dotnet_debug_cwd
			result.project_found = true
			return result
		end
	end
	result.project_found = false
	return result
end

return M
