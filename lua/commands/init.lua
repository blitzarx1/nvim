vim.api.nvim_create_user_command(
  "ConfigOpen",
  function(opts)
    require("commands/config_open").config_open(opts)
  end,
  { nargs = "*" }
)
