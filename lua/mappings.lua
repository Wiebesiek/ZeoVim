local set = vim.keymap.set
local builtin = require('telescope.builtin')
local neotest = require('neotest')

set('v', '<c-C>', '"*y')
set('n', '<C-j>', ":cn<CR>")
set('n', '<C-k>', ":cp<CR>")
set('n', '<leader>e', ":Neotree toggle <CR>", {})
---------------
-- TELESCOPE --
---------------
set('n', '<leader>gb', builtin.git_branches, {})
set('n', '<leader>gc', builtin.git_commits, {})
set('n', '<leader>gt', builtin.git_status, {})
set('n', '<leader>ff', builtin.find_files, {})
set('n', '<leader>fg', builtin.live_grep, {})
set('n', '<leader>fb', builtin.buffers, {})
set('n', '<leader>fh', builtin.help_tags, {})
set('n', "<leader>fw",
	function()
		builtin.live_grep {
			additional_args = function(args)
				return vim.list_extend(args, { "--hidden", "--no-ignore" })
			end,
		}
	end
)
set('n', '<leader>f<CR>', builtin.resume, {})
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


-------------
-- LSP MAPPINGS --

-------------------------------------------------------------
-----------------------LspAttach----------------------------
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
-------------------------------------------------------------
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o> -- what is this?
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		set('n', 'gD', vim.lsp.buf.declaration, opts)
		set('n', 'gd', function() builtin.lsp_definitions() end, opts)
		set('n', 'gi', function() builtin.lsp_implementations() end, opts)
		set('n', 'gr', function()
			builtin.lsp_references({
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
		set('n', 'go', function() builtin.lsp_document_symbols() end, opts)
		set('n', 'gO', function() builtin.lsp_workspace_symbols() end, opts)
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
		set('n', '<F5>', function() require 'dap'.continue() end)
		set('n', '<F7>', function() require 'dap'.step_into() end)
		set('n', '<F8>', function() require 'dap'.step_over() end)
		set('n', '<F12>', function() require 'dap'.step_out() end)
		set('n', '<leader>b', function() require 'dap'.toggle_breakpoint() end)
	end,
})

-----------------
-- Test Runner --
-----------------
local neotest_dap = function()
	if vim.bo.filetype == "cs" then
		neotest.run.run({ strategy = require("neotest-dotnet.strategies.netcoredbg"), is_custom_dotnet_debug = true })
	else
		neotest.run.run({ strategy = "dap" })
	end
end

set('n', '<leader>td', neotest_dap)
set('n', '<leader>tn', function() neotest.run.run() end)
set('n', '<leader>tt', function() neotest.output_panel.toggle() end)
set('n', '<leader>tw', function() neotest.output.open({ enter = true }) end)
set('n', '<leader>tf', function() neotest.run.run(vim.fn.expand("%")) end)
