local map   = vim.keymap.set
local opts  = { noremap = true, silent = true }

map('n', '-', ':Ex<CR>', opts) -- open explorer with '-'
vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    local opts = { noremap = true, silent = true, buffer = true }
    vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
    vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
    vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
    vim.keymap.set("n", "<C-l>", "<C-w>l", opts)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
   vim.o.colorcolumn = "0" -- disable colorcolumn
  end,
})

-- Netrw default view: long (shows sizes and dates)
vim.g.netrw_liststyle = 1

-- Disable the banner at the top
vim.g.netrw_banner = 0

-- Human-readable sizes (K, M, G)
vim.g.netrw_sizestyle = "h"
