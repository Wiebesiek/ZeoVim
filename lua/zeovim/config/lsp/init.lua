require("zeovim.config.lsp.lua_ls")
require("zeovim.config.lsp.omnisharp")
require("lspconfig").tsserver.setup {}
require("lspconfig").volar.setup {}
require("lspconfig").pylsp.setup {}
