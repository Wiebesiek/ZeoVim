local builtin = function()
	return require('telescope.builtin')
end
local set = vim.keymap.set

set('v', '<c-C>', '"*y')
set('n', '<C-j>', ":cn<CR>")
set('n', '<C-k>', ":cp<CR>")
set('n', 's', ":HopWord<CR>", { silent = true })
set('n', '<leader>e', ":Neotree toggle <CR>", { desc = "Toggle Neotree" })
set('n', '<leader><C-g>', ":let @+ = expand('%:p')<CR>", { desc = "Copy current file path to clipboard" })
set('n', '<leader>nt', ":ProjTermToggle<CR>",
	{ desc = "Opens a new terminal in current file directory" })

set('n', '[d', vim.diagnostic.goto_prev)
set('n', ']d', vim.diagnostic.goto_next)
set('n', '<leader>q', vim.diagnostic.open_float)
set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
	{ silent = true, noremap = true }
)
set('n', '<leader>z', ":ZenMode<CR>", { desc = "Toggle Zen Mode" })
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
		local opts = { buffer = ev.buf }
		set('n', 'gD', vim.lsp.buf.declaration, opts)
		-- TODO: Can these be sourced from mappings.telescope?
		set('n', 'gd', function() builtin().lsp_definitions() end, opts)
		set('n', 'gi', function() builtin().lsp_implementations() end, opts)
		set('n', 'gr', function()
			builtin().lsp_references({
				initial_mode = "insert", -- NOT DEFAULT
				trim_text = true,
				path_display = { truncate = 20 },
				fname_width = 80,
			})
		end, opts)
		set('n', 'go', function()
			builtin().lsp_document_symbols({symbol_width = 50})
		end, opts)
		set('n', 'gO', function() builtin().lsp_workspace_symbols({symbol_width = 30, path_display = {"tail"}}) end, opts)
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
		-- Just uses language server's default
		set('n', '<leader>F', function()
			vim.lsp.buf.format({
				async = true,
			})
		end, opts)
		-- TODO: put in it's own file
		-- DAP --
		set('n', '<F5>', function() require 'dap'.continue() end, { desc = 'DAP: Continue' })
		set('n', '<F7>', function() require 'dap'.step_into() end, { desc = 'DAP: Step Into' })
		set('n', '<F8>', function() require 'dap'.step_over() end, { desc = 'DAP: Step Over' })
		set('n', '<F9>', function() require 'dap'.step_out() end, { desc = 'DAP: Step Out' })
		set('n', '<F12>', function() require 'dap'.close() end, { desc = 'DAP: Close' })
		set('n', '<leader>b', function() require 'dap'.toggle_breakpoint() end, { desc = 'DAP: Toggle Breakpoint' })
	end,
})
