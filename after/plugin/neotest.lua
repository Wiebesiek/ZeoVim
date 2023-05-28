local status, neotest = pcall(require, "neotest")
if (not status) then
	print("neotest not loaded")
	return
end

neotest.setup({
	adapters = {
		require("neotest-dotnet")({
			-- Extra arguments for nvim-dap configuration
			-- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
			dap = { justMyCode = false },
			-- Let the test-discovery know about your custom attributes (otherwise tests with not be picked up)
			-- Note: Only custom attributes for non-parameterized tests should be added here. See the support note about parameterized tests
			-- custom_attributes = {
			-- 	xunit = { "MyCustomFactAttribute" },
			-- 	nunit = { "MyCustomTestAttribute" },
			-- 	mstest = { "MyCustomTestMethodAttribute" }
			-- },
			-- Tell neotest-dotnet to use either solution (requires .sln file) or project (requires .csproj or .fsproj file) as project root
			-- Note: If neovim is opened from the solution root, using the 'project' setting may sometimes find all nested projects, however,
			--       to locate all test projects in the solution more reliably (if a .sln file is present) then 'solution' is better.
			discovery_root = "project" -- Default
		})
	}
})
