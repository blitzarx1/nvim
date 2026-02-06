-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ 
    "git", 
    "clone", 
    "--filter=blob:none", 
    "--branch=stable", 
    lazyrepo, 
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({ spec = { 
    { import = 'config.plugins.colorscheme' },

    { import = 'config.plugins.nvim-cmp' },
    { import = 'config.plugins.vim-easy-align' },
    { import = 'config.plugins.neogit' },
    { import = 'config.plugins.gitsigns' },
    { import = 'config.plugins.nvim-treesitter' },
    { import = 'config.plugins.nvim-treesitter-context' },
    { import = 'config.plugins.telescope-nvim' },
    { import = 'config.plugins.copilot' },
    { import = 'config.plugins.mason'},
    { import = 'config.plugins.nvim-surround' },

    { import = 'config.plugins.todoer' },
  },
})
