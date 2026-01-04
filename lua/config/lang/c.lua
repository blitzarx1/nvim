local c_group = vim.api.nvim_create_augroup('CLocalOpts', { clear = true })

vim.api.nvim_create_autocmd({ 'FileType', 'WinEnter' }, {
  group = c_group,
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if ft ~= 'c' and ft ~= 'h' then
      return
    end

    vim.wo.colorcolumn = '80'
  end,
})
