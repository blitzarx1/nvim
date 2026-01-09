return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      current_line_blame = true,
    },
    config = function()
      local gs = require('gitsigns')
      local opts  = { noremap = true, silent = true }
      vim.keymap.set('n', ']g', function() gs.nav_hunk('next') end, opts)
      vim.keymap.set('n', '[g', function() gs.nav_hunk('prev') end, opts)
    end,
  },
}

