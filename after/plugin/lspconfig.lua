-- TODO: Have mason install prettierd and csharpier
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "omnisharp", "tsserver", "volar", "pylsp" }
})
require("mason-nvim-dap").setup({
	ensure_installed = { "python", "coreclr", "node2", "js", "chrome" }
})
require("mason-null-ls").setup({
	ensure_installed = { "prettierd", "csharpier" }
})

---------------
-- OMNISHARP --
---------------
require("lspconfig").omnisharp.setup {
	on_attach = function(client, _)
		-- This is a hack that is needed with omnisharp in it's current state. This the result of a bug in Rosyln.
		if client.name == "omnisharp" then
			client.server_capabilities.semanticTokensProvider.legend = {
				tokenModifiers = { "static" },
				tokenTypes = { "comment", "excluded", "identifier", "keyword", "keyword", "number", "operator", "operator",
					"preprocessor", "string", "whitespace", "text", "static", "preprocessor", "punctuation", "string",
					"string", "class", "delegate", "enum", "interface", "module", "struct", "typeParameter", "field",
					"enumMember", "constant", "local", "parameter", "method", "method", "property", "event", "namespace",
					"label", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml",
					"xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "regexp", "regexp", "regexp", "regexp", "regexp",
					"regexp", "regexp", "regexp", "regexp" }
			}
		end
	end,
	root_dir = function(path)
		--[[
		** This is standard root_dir function for omnisharp. **
		local lspconfig_pattern = root_pattern('*.sln')(path)
		--]]
		local root_pattern = require('lspconfig.util').root_pattern
		local pattern = require("utilities.path_helpers").OuterMostSln(path) or root_pattern("*.csproj")(path)
		return pattern
	end
}
require("lspconfig").tsserver.setup {}
require("lspconfig").volar.setup {}
require("lspconfig").pylsp.setup {}
