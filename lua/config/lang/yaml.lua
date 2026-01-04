local yaml_group = vim.api.nvim_create_augroup('YamlLocalOpts', { clear = true })

vim.api.nvim_create_autocmd({ 'FileType', 'WinEnter' }, {
  group = yaml_group,
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if ft ~= 'yaml' and ft ~= 'yml' then
      return
    end

    local bo = vim.bo[args.buf]
    bo.expandtab = true
    bo.shiftwidth = 2
    bo.softtabstop = 2

    vim.wo.colorcolumn = ''
  end,
})
