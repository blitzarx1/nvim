return {
    {
      "stevearc/oil.nvim",
      config = function()
        require("oil").setup({
          columns = { "icon" },
          keymaps = {
            ["C-h"] = false,
            ["M-h"] = "actions.select_split",
            ["-"] = "actions.parent",
          },
          view_options = {
              show_hidden = true,
          },
        })

        vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" } )
        -- vim.keymap.set("n", "<leader>-", require("oil").toggle_float, { desc = "Toggle floating oil window" } )
      end,
    }
}
