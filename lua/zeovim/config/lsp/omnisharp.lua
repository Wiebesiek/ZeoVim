---------------
-- OMNISHARP --
---------------
require("lspconfig").omnisharp.setup({
	cmd = {"dotnet", require("utilities.path_finder").GetOmniSharpDll()},
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
		return require("utilities.path_finder").GetLspRootDir(path)
	end
})
