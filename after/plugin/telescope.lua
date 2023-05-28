local status, telescope = pcall(require, "telescope")
if (not status) then
	print("telescope not loaded")
	return
end
local actions = require "telescope.actions"
telescope.setup({

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
})

require("telescope").load_extension("ui-select")
