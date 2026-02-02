return {
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup({
        view = {
          width = 60,
        },
        renderer = {
          highlight_git = true,
          highlight_opened_files = "all",
        },
        update_focused_file = { enable = true },
        git = {
          enable = true,
          ignore = false,
        },
      })
    end,
  }
}
