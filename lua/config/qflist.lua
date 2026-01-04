-- Always move quickfix window to the very bottom, spanning full width
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.cmd("wincmd J")  -- move it to the bottom of all splits
    vim.cmd("resize 10") -- optional: fix its height (adjust as you like)
  end,
})

-- Automatically open quickfix window if there are entries after certain
-- commands
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  pattern = { "make", "grep", "grepadd", "vimgrep", "vimgrepadd" },
  callback = function()
    -- open quickfix if there are entries
    if vim.fn.getqflist({ size = 0 }).size > 0 then
      vim.cmd("cwindow")
      vim.cmd("wincmd p")  -- go back to previous window
    end
  end,
})
