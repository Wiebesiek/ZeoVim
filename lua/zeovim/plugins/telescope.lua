local actions = require "telescope.actions"

-- telescope.load_extension("ui-select")
return{
	"nvim-telescope/telescope.nvim",
	tag = '0.1.x',
	dependencies = {
		'nvim-lua/plenary.nvim',
		"nvim-telescope/telescope-ui-select.nvim"
	},
	cmd = "Telescope",
	opts = {
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_dropdown {
				},
			}
		},
		defaults = {
			-- No idea how this isn't the default
			layout_config = {
				horizontal = {
					prompt_position = "top"
				}
			},
			path_display = { truncate = true },
			-- path_display = { smart = true, truncate = true },
			sorting_strategy = "ascending",
		},
		pickers = {
			buffers = {
				mappings = {
					i = {
						["<c-x>"] = actions.delete_buffer + actions.move_to_top,
					}
				}
			}
		}
	}
}

