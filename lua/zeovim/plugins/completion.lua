local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp = require("cmp")
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
return {
"hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "hrsh7th/cmp-buffer", -- Buffer Completions
    "hrsh7th/cmp-path", -- Path Completions
    "saadparwaiz1/cmp_luasnip", -- Snippet Completions
    "hrsh7th/cmp-nvim-lsp", -- LSP Completions
    "hrsh7th/cmp-nvim-lua", -- Lua Completions
    "hrsh7th/cmp-cmdline", -- CommandLine Completions
    "L3MON4D3/LuaSnip",
    },
		opts = {
			snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = {
				['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
				['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i' }),
				['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
				['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i' }),
				['<CR>'] = cmp.mapping.confirm({ select = false }),  -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			},
			sources = cmp.config.sources {
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
				{ name = 'buffer' },
				{ name = 'cmd' }
			}
	}
}
