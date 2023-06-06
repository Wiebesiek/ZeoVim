local builtin = function()
	return require('telescope.builtin')
end
local set = vim.keymap.set
-- TODO: saving this for potential launching of a terminal for dotnet commands.
local current_file_dir = function()
	return vim.fn.expand('%:p:h')
end

set('v', '<c-C>', '"*y')
set('n', '<C-j>', ":cn<CR>")
set('n', '<C-k>', ":cp<CR>")
set('n', '<leader>e', ":Neotree toggle <CR>", { desc = "Toggle Neotree" })
set('n', '<leader><C-g>', ":let @+ = expand('%:p')<CR>", { desc = "Copy current file path to clipboard" })
set('n', '<leader>nt', ":ToggleTerm dir=" .. current_file_dir() .. "<CR>",
	{ desc = "Opens a new terminal in current file directory" })

-- TODO: Creat Custom terminal for dotnet commands
-- TODO: Needs to be destroyed on close though
-- CUSTOM TERMINAL USAGE
--
-- >lua
--     local Terminal  = require('toggleterm.terminal').Terminal
--     local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
--     
--     function _lazygit_toggle()
--       lazygit:toggle()
--     end
--     
--     vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
-- <
--
-- This will create a new terminal, but the specified command is not being run
-- immediately. The command will run once the terminal is opened. Alternatively
-- `term:spawn()` can be used to start the command in a background buffer without
-- opening a terminal window yet. If the `hidden` key is set to true, this
-- terminal will not be toggled by normal toggleterm commands such as
-- `:ToggleTerm` or the open mapping. It will only open and close by using the
-- returned terminal object. A mapping for toggling the terminal can be set as in
-- the example above.
set('n', '[d', vim.diagnostic.goto_prev)
set('n', ']d', vim.diagnostic.goto_next)
set('n', '<leader>q', vim.diagnostic.setloclist)
set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
	{ silent = true, noremap = true }
)

-------------
-- COPILOT --
-------------
set('i', '<C-j>', 'copilot#Accept("<CR>")', { noremap = true, silent = true, expr = true, replace_keycodes = false })


--- TODO: Move to mappings.lsp
-------------------------------------------------------------
-----------------------LspAttach----------------------------
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
-------------------------------------------------------------
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		-- local buf = ev.buf -- TODO: anonymous funciton scoping issue?
		-- local opts = function(description)
		-- 	return {
		-- 		-- buffer = true,
		-- 		desc = description
		-- 	}
		-- end
		local opts = { buffer = ev.buf }
		set('n', 'gD', vim.lsp.buf.declaration, opts)
		-- TODO: Can these be sourced from mappings.telescope?
		set('n', 'gd', function() builtin().lsp_definitions() end, opts)
		set('n', 'gi', function() builtin().lsp_implementations() end, opts)
		set('n', 'gr', function()
			builtin().lsp_references({
				initial_mode = "insert", -- NOT DEFAULT
				trim_text = true,
				include_current_line = true,
				-- path_display = { shorten = { len = 1, exclude = { -1, -2 } } },
				-- hacky, but can't figure out how to disable non-path related text
				-- shorten can be used in conjuction to make it cleaner in the future
				path_display = { truncate = 20 },
				fname_width = 80,
			})
		end, opts)
		set('n', 'go', function() builtin().lsp_document_symbols() end, opts)
		set('n', 'gO', function() builtin().lsp_workspace_symbols() end, opts)
		set('n', 'K', vim.lsp.buf.hover, opts)
		set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
		set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
		set('n', '<leader>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
		set('n', '<leader>rn', vim.lsp.buf.rename, opts)
		-- TODO: use telescope-ui-select
		-- https://github.com/nvim-telescope/telescope-ui-select.nvim
		set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
		set('n', '<leader>F', function()
			vim.lsp.buf.format({
				async = true,
			})
		end, opts)
		-- DAP --
		set('n', '<F5>', function() require 'dap'.continue() end, { desc = 'DAP: Continue' })
		set('n', '<F7>', function() require 'dap'.step_into() end, { desc = 'DAP: Step Into' })
		set('n', '<F8>', function() require 'dap'.step_over() end, { desc = 'DAP: Step Over' })
		set('n', '<F12>', function() require 'dap'.step_out() end, { desc = 'DAP: Step Out' })
		set('n', '<leader>b', function() require 'dap'.toggle_breakpoint() end, { desc = 'DAP: Toggle Breakpoint' })
	end,
})

