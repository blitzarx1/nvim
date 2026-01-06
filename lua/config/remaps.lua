vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

local map   = vim.keymap.set
local opts  = { noremap = true, silent = true }

-- Jump forward by paragraph
map({ 'n', 'x', 'o' }, '<A-j>', '}', opts)

-- Jump backward by paragraph
map({ 'n', 'x', 'o' }, '<A-k>', '{', opts)

-- Splits navigation
map('n', '<C-h>', '<cmd>wincmd h<CR>', opts)
map('n', '<C-j>', '<cmd>wincmd j<CR>', opts)
map('n', '<C-k>', '<cmd>wincmd k<CR>', opts)
map('n', '<C-l>', '<cmd>wincmd l<CR>', opts)

map('n', '<Esc>', '<cmd>nohlsearch<CR>', opts)

-- Search within visual selection
vim.keymap.set("x", "/",function()
  -- Exit Visual so the selection highlight doesn't mask matches
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
  -- Start search, restricted to the previous visual area, literal
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("/\\%V", true, false, true), "n", false)
end, opts)
