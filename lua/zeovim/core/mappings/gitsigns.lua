local M = {}

function M.mappings(bufnr)
	local gs = package.loaded.gitsigns

	local function map(mode, l, r, opts)
		opts = opts or {}
		opts.buffer = bufnr
		vim.keymap.set(mode, l, r, opts)
	end

	-- Navigation
	map('n', ']c', function()
		if vim.wo.diff then return ']c' end
		vim.schedule(function() gs.next_hunk() end)
		return '<Ignore>'
	end, { expr = true })

	map('n', '[c', function()
		if vim.wo.diff then return '[c' end
		vim.schedule(function() gs.prev_hunk() end)
		return '<Ignore>'
	end, { expr = true })

	-- Actions
	map('n', '<leader>hs', gs.stage_hunk, { desc = 'Stage Hunk' })
	map('n', '<leader>hr', gs.reset_hunk, { desc = 'Reset Hunk' })
	map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end, {desc = 'Visual Stage Hunk'})
	map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end, {desc = 'Visual Reset Hunk'})
	map('n', '<leader>hS', gs.stage_buffer, { desc = 'Stage Buffer' })
	map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Undo Stage Hunk' })
	map('n', '<leader>hR', gs.reset_buffer, { desc = 'Reset Buffer' })
	map('n', '<leader>hp', gs.preview_hunk, { desc = 'Preview Hunk' })
	map('n', '<leader>hb', function() gs.blame_line { full = true } end, { desc = 'Blame Line' })
	map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'Toggle Blame' })
	map('n', '<leader>hd', gs.diffthis, { desc = 'Diff This' })
	map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = 'Diff This --Ignore Whitespace)' })
	map('n', '<leader>hl', gs.toggle_deleted, { desc = 'Toggle Deleted' })

	-- Text object
	map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
end

return M
