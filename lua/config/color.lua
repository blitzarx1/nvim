local o = vim.o

o.syntax = "enable"

-- Make bright selection
-- vim.api.nvim_create_autocmd("ColorScheme", {
--   callback = function()
--     -- non-text chars
--     vim.api.nvim_set_hl(0, "NonText",   { fg = "#404040", bg = "NONE" })
-- 
--     -- selection
--     local bg = "#eb6f92"
--     local fg = "#ffffff"
--     vim.api.nvim_set_hl(0, "Visual",   { bg = bg, fg = fg })
--     vim.api.nvim_set_hl(0, "VisualNOS",{ bg = bg, fg = fg })
--   end,
-- })
