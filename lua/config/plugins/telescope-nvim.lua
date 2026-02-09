return{{
    'nvim-telescope/telescope.nvim', tag = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>/', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>s', builtin.lsp_document_symbols, { desc = 'LSP symbols (buffer)' })
      vim.keymap.set('n', 'gd', builtin.lsp_definitions, { desc = 'LSP definitions' })
      vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = 'LSP references' })
      vim.keymap.set('n', 'gi', builtin.lsp_implementations, { desc = 'LSP implementations' })
      vim.keymap.set('n', 'gy', builtin.lsp_type_definitions, { desc = 'LSP type definitions' })
    end,
}}
