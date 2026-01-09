return {
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      local gs = require('gitsigns').setup({
        current_line_blame = true, 
      })
      local opts  = { noremap = true, silent = true }
      vim.keymap.set('n', ']g', function() gs.nav_hunk('next') end, opts)
      vim.keymap.set('n', '[g', function() gs.nav_hunk('prev') end, opts)
    end,
  },
}

