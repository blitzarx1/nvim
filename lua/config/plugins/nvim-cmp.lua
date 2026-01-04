return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
    config = function()
      local cmp = require'cmp'	

      cmp.setup{
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path'},
        },
        preselect = cmp.PreselectMode.Item,
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-p>'] = cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Insert,
          }),
          ['<C-n>'] = cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Insert,
          }),
          ['<C-k>'] = cmp.mapping.scroll_docs(-4),
          ['<C-j>'] = cmp.mapping.scroll_docs(4),

          ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              -- confirm the currently selected item
              -- (the first item will be selected by preselect)
              cmp.confirm({ select = true })
              return
            end

            fallback()
          end, { "i" }),
        }),
        view = {
          entries = 'native',
        },
        formatting = {
          format = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = '[LSP]',
              buffer   = '[Buffer]',
              path     = '[Path]',
            })[entry.source.name]
            return vim_item
          end
        },
      }

    end
  }
}

