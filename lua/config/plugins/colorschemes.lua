return {
  {
    "rose-pine/neovim",
    priority = 1000,
    config = function()
      local function apply_overrides()
        -- non-text chars
        vim.api.nvim_set_hl(0, "NonText", { fg = "#404040", bg = "NONE" })

        -- selection
        vim.api.nvim_set_hl(0, "Visual",    { bg = '#eb6f92', fg = '#ffffff' })
        vim.api.nvim_set_hl(0, "VisualNOS", { bg = '#eb6f92', fg = '#ffffff' })

        -- search
        vim.api.nvim_set_hl(0, "Search",    { bg = "#3e4451", fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "IncSearch", { bg = "#eb6f92", fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "CurSearch", { bg = "#eb6f92", fg = "#ffffff" })

        -- colorcolumn
        vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#2c2f38", })
      end

      local group = vim.api.nvim_create_augroup("ColorOverrides", { clear = true })

      vim.api.nvim_create_autocmd("ColorScheme", {
        group = group,
        callback = apply_overrides,
      })

      vim.cmd.colorscheme("rose-pine-moon")
      apply_overrides() -- ensure it applies on startup too
    end,
  },
}
