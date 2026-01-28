require'config.lang.lua'
require'config.lang.c'
require'config.lang.go'
require'config.lang.yaml'

-- -- LSP enable
vim.lsp.enable("luals")
vim.lsp.enable("gopls")
vim.lsp.enable("rust-analyzer")
