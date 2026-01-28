local go_group = vim.api.nvim_create_augroup('GoLocalOpts', { clear = true })

vim.api.nvim_create_autocmd({ 'FileType', 'WinEnter' }, {
  group = go_group,
  callback = function(args)
    if vim.bo[args.buf].filetype ~= 'go' then
      return
    end

    vim.wo.colorcolumn = '120'
  end,
})

-- lsp setup
local capabilities = require('cmp_nvim_lsp').default_capabilities();

vim.lsp.config["gopls"] = {
	capabilities = capabilities,
	cmd = {"gopls"},
	filetypes = {"go"},
}

