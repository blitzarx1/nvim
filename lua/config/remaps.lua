vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local map   = vim.keymap.set
local opts  = { noremap = true, silent = true }

-- Jump forward by paragraph
map({ "n", "x", "o" }, "<A-j>", "}", opts)

-- Jump backward by paragraph
map({ "n", "x", "o" }, "<A-k>", "{", opts)

map('n', '<C-h>', '<cmd>wincmd h<CR>', opts)
map('n', '<C-j>', '<cmd>wincmd j<CR>', opts)
map('n', '<C-k>', '<cmd>wincmd k<CR>', opts)
map('n', '<C-l>', '<cmd>wincmd l<CR>', opts)
