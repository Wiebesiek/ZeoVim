--local status, tokyonight = pcall(require, "tokyonight")
--if (not status) then
--	error("Tokyonight colorscheme not installed. Please run PackerSync.")
--end
return {{
    "folke/tokyonight.nvim",
lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
opts = {
  style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  light_style = "day", -- The theme is used when the background is set to light
  transparent = false, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { italic = false }, -- NOT DEFAULT
    functions = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "dark", -- style for sidebars, see below
    floats = "dark", -- style for floating windows
  },
  sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  dim_inactive = true, -- dims inactive windows -- NOT DEFAULT
  lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

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
config = function() vim.cmd([[colorscheme tokyonight]]) end
},

-- local status,  gruvbox = pcall(require, "gruvbox")
-- if (not status) then
-- 	error("Gruvbox colorscheme not installed. Please run PackerSync.")
-- end
-- 
{
	"ellisonleao/gruvbox.nvim",
opts =
{
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = false,
    comments = false,
    operators = false,
    folds = true,
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
  dim_inactive = false,
  transparent_mode = true,
}
}
}

-- if (not status) then
--	error("Tokyonight colorscheme not installed. Please run PackerSync.")
-- end
-- Set defalt, complain if not there
-- status = pcall(function () vim.cmd.colorscheme("tokyonight") end) -- use tokyonight to inherit from config
--status = pcall(function () vim.cmd.colorscheme("gruvbox") end)
--if (not status) then
--	error("Colorscheme not installed. Please run PackerSync.")
--end
