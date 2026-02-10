return{{
    'nvim-telescope/telescope.nvim', tag = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      local make_entry = require('telescope.make_entry')
      local telescope_utils = require('telescope.utils')

      local compact_vimgrep_entry = function(opts)
        local base_entry_maker = make_entry.gen_from_vimgrep(opts)
        return function(line)
          local entry = base_entry_maker(line) if not entry then
            return nil
          end

          entry.display = function(e)
            local path = telescope_utils.transform_path(opts, e.filename)
            return string.format('%s:%s', path, e.lnum or '?')
          end

          return entry
        end
      end

      require('telescope').setup({
        pickers = {
          find_files = {
            hidden = true,
            no_ignore = true,
            no_ignore_parent = true,
          },
          live_grep = {
            entry_maker = compact_vimgrep_entry({}),
          },
          grep_string = {
            entry_maker = compact_vimgrep_entry({}),
          },
          lsp_references = {
            show_line = false,
          },
          lsp_definitions = {
            show_line = false,
          },
          lsp_implementations = {
            show_line = false,
          },
          lsp_type_definitions = {
            show_line = false,
          },
        },
      })

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
