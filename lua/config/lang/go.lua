local go_group = vim.api.nvim_create_augroup('GoLocalOpts', { clear = true })

vim.api.nvim_create_autocmd({ 'FileType', 'WinEnter' }, {
  group = go_group,
  callback = function(args)
    if vim.bo[args.buf].filetype ~= 'go' then
      return
    end

    vim.bo[args.buf].makeprg = 'go build ./...'

    vim.wo.colorcolumn = ''
  end,
})
