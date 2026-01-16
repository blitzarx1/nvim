-- remaps
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

local map   = vim.keymap.set
local opts  = { noremap = true, silent = true }

map('n', 'gr', vim.lsp.buf.references, opts)
map('n', 'gd', vim.lsp.buf.definition, opts)
map('n', 'gi', vim.lsp.buf.implementation, opts)
map('n', 'gy', vim.lsp.buf.type_definition, opts)
map('n', '<leader>r', vim.lsp.buf.rename, opts)
map('n', '<leader>k', vim.lsp.buf.hover, opts)
map('n', '<leader>a', vim.lsp.buf.code_action, opts)
map('n', '<leader>d', vim.diagnostic.open_float, opts)
map('n', '<leader>D', function() vim.diagnostic.setqflist({ open = true }) end, opts)
map({'n', 'i'}, '<C-k>', vim.lsp.buf.signature_help, opts)

-- disable diagnostic
vim.diagnostic.enable(false)

