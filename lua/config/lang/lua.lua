local lua_group = vim.api.nvim_create_augroup('LuaLocalOpts', { clear = true })

vim.api.nvim_create_autocmd({ 'FileType', 'WinEnter' }, {
  group = lua_group,
  callback = function(args)
    if vim.bo[args.buf].filetype ~= 'lua' then
      return
    end
    
    local bo = vim.bo[args.buf]
    bo.expandtab = true
    bo.shiftwidth = 2
    bo.softtabstop = 2

    vim.wo.colorcolumn = '80'
  end,
})
