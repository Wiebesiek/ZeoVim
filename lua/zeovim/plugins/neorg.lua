return {
	"nvim-neorg/neorg",
	build = ":Neorg sync-parsers",
	ft = "norg",
	cmd = { "Neorg" },
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("neorg").setup {
			load = {
				["core.defaults"] = {}, -- Loads default behaviour
				["core.concealer"] = {}, -- Adds pretty icons to your documents
				["core.keybinds"] = {
					config = {
						hook = function(keybinds)
							keybinds.remap_key("norg", "n", "<C-Space>", "<Leader>t")
						end,
					}
				},
				["core.dirman"] = { -- Manages Neorg workspaces
					config = {
						workspaces = {
							notes = "$NOTESDIR", -- Set to an environment variable
						},
						default_workspace = "notes",
					},
				},
			},
		}
	end,
}
