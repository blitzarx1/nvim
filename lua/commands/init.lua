vim.api.nvim_create_user_command(
  "ConfigOpen",
  function(opts)
    require("commands/config_open").config_open(opts)
  end,
  { nargs = "*" }
)

vim.api.nvim_create_user_command(
  'Fmt',
  function ()
    vim.lsp.buf.format()
  end,
  {}
)

vim.api.nvim_create_user_command(
  'GitLink',
  function(cmdopts)
    require('commands/gitlink').copy_link({ line1 = cmdopts.line1, line2 = cmdopts.line2 })
  end,
  { range = true }
)

