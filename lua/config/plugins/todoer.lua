return {
  { 
    dir = '~/dev/todoer.nvim',
    keys = {
      { "<leader>tt", "<cmd>Todoer<cr>", desc = "Todoer list" },
    },
    config = function()
      require("todoer").setup({
        keymaps = false, -- don't create plugin-defined keymaps
      })
    end,
  }
}
