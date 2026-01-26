return {
  {
    'silentium-theme/silentium.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      local silentium = require("silentium")
      silentium.setup({ accent = silentium.accents.peach })

      vim.cmd("colorscheme silentium")
      -- Accent blue selection with dark fg for contrast, like accent-backed UI groups
      vim.api.nvim_set_hl(0, "Visual", { bg = silentium.accents.blue, fg = silentium.colors.dark })
      vim.api.nvim_set_hl(0, "VisualNOS", { bg = silentium.accents.blue, fg = silentium.colors.dark })
    end
  }
  -- {
  --   'projekt0n/github-nvim-theme',
  --   name = 'github-theme',
  --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     require('github-theme').setup({
  --       -- setup parameters here
  --     })

  --     vim.cmd('colorscheme github_dark_dimmed')
  --   end,
  -- }
}
