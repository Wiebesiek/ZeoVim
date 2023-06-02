-- TODO: Add more colorschemes
-- TODO: Extract transparent and italics to a config value.
local italics = false
local transparent = true
local dim_inactive = false
return {
	{
		"folke/tokyonight.nvim",
		lazy = true,              -- make sure we load this during startup if it is your main colorscheme
		opts = {
			style = "storm",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
			light_style = "day",    -- The theme is used when the background is set to light
			transparent = transparent, -- Enable this to disable setting the background color
			terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
			styles = {
				-- Style to be applied to different syntax groups
				-- Value is any valid attr-list value for `:help nvim_set_hl`
				comments = { italic = italics }, -- NOT DEFAULT
				keywords = { italic = false }, -- NOT DEFAULT
				functions = {},
				variables = {},
				-- Background styles. Can be "dark", "transparent" or "normal"
				sidebars = "dark",           -- style for sidebars, see below
				floats = "dark",             -- style for floating windows
			},
			sidebars = { "qf", "help" },   -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
			day_brightness = 0.3,          -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
			hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
			dim_inactive = dim_inactive,   -- dims inactive windows -- NOT DEFAULT
			lualine_bold = false,          -- When `true`, section headers in the lualine theme will be bold

			--- You can override specific color groups to use other groups or a hex color
			--- function will be called with a ColorScheme table
			---@param colors ColorScheme
			on_colors = function(colors) end,

			--- You can override specific highlights to use other groups or a hex color
			--- function will be called with a Highlights and ColorScheme table
			---@param highlights Highlights
			---@param colors ColorScheme
			on_highlights = function(highlights, colors) end,
		},
	},
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		opts = {
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = false,
				comments = false,
				operators = false,
				folds = false,
			},
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			invert_intend_guides = false,
			inverse = false, -- invert background for search, diffs, statuslines and errors
			contrast = "soft", -- can be "hard", "soft" or empty string
			palette_overrides = {},
			overrides = {},
			dim_inactive = dim_inactive,
			transparent_mode = transparent,
		},
		config = function(_, opts)
			require("gruvbox").setup(opts)
			vim.cmd([[colorscheme gruvbox]])
		end
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
		opts = {
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			background = {
				-- :h background
				light = "latte",
				dark = "mocha",
			},
			transparent_background = false, -- needs to be false for current console bg
			show_end_of_buffer = false, -- show the '~' characters after the end of buffers
			term_colors = false,
			dim_inactive = {
				enabled = dim_inactive,
				shade = "dark",
				percentage = 0.15,
			},
			no_italic = false, -- Force no italic
			no_bold = false,   -- Force no bold
			no_underline = false, -- Force no underline
			styles = {
				comments = {},   -- needs to be a string "italic"
				conditionals = {},
				loops = {},
				functions = {},
				keywords = {},
				strings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
				operators = {},
			},
			color_overrides = {},
			custom_highlights = {},
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				telescope = true,
				notify = false,
				mini = false,
				neotree = true,
				-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
			},
		},

	}
}
