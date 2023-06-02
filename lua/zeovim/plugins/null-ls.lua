return{
	"jose-elias-alvarez/null-ls.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = function()
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		local lsp_formatting = function(buffer)
			vim.lsp.buf.format({
				filter = function(client)
					-- By default, ignore any formatters provider by other LSPs
					-- (such as those managed via lspconfig or mason)
					return client.name == "null-ls"
				end,
				bufnr = buffer,
			})
		end

		-- Format on save
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts#neovim-08
		local on_attach = function(client, buffer)
			-- the Buffer will be null in buffers like nvim-tree or new unsaved files
			if (not buffer) then
				return
			end

			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = buffer })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = buffer,
					callback = function()
						lsp_formatting(buffer)
					end,
				})
			end
		end
		local null_ls = require("null-ls")
		return{
			debug = true,
			sources = {
				null_ls.builtins.formatting.csharpier,
				null_ls.builtins.formatting.prettierd,
			},
			-- This works for csharpier, but may cause issues for diagnostics or other null-ls things
			root_dir = require("null-ls.utils").root_pattern(
				".null-ls-root",
				"*.sln",
				"*.csproj",
				"package.json",
				"Makefile",
				".git"),
			on_attach = on_attach

		}
	end,
	config = function (_, opts)
		require("null-ls").setup(opts)
	end
}
