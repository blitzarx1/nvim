-- ######## COLORS   ########

vim.pack.add({
    {src = "https://github.com/silentium-theme/silentium.nvim"}
})
require"silentium".setup({ accent = require"silentium".accents.peach })
vim.cmd("colorscheme silentium")
vim.api.nvim_set_hl(0, "Visual", { bg = "#B3D7FF", fg = require"silentium".colors.dark })
vim.api.nvim_set_hl(0, "VisualNOS", { bg = "#B3D7FF", fg = require"silentium".colors.dark })

-- ######## OPTIONS  ########

vim.o.syntax = "off"

vim.o.number = true
vim.o.relativenumber = true

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

vim.o.list = true
vim.o.listchars = "tab:▸ ,space:·,trail:·,extends:›,precedes:‹,eol:$"

vim.o.ignorecase = true
vim.o.smartcase = true

vim.opt.grepprg = "rg --vimgrep --smart-case --hidden --glob '!.git/'"
vim.opt.grepformat = "%f:%l:%c:%m"

-- ######## REMAPS   ########

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- jump paragraphs
vim.keymap.set({ "n", "x", "o" }, "<A-j>", "}")
vim.keymap.set({ "n", "x", "o" }, "<A-k>", "{")

-- splits
vim.keymap.set("n", "<C-h>", "<cmd>wincmd h<CR>")
vim.keymap.set("n", "<C-j>", "<cmd>wincmd j<CR>")
vim.keymap.set("n", "<C-k>", "<cmd>wincmd k<CR>")
vim.keymap.set("n", "<C-l>", "<cmd>wincmd l<CR>")

-- remove highlight on esc
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("x", "/",function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("/\\%V", true, false, true), "n", false)
end, { desc = "Search inside selection" })

-- ######## COMMANDS ########

vim.api.nvim_create_user_command( "BufOnly", function () vim.cmd("silent! %bd | e# | bd#") end, {})
vim.keymap.set("n", "<leader>o", ":BufOnly<CR>", { desc = "Close other buffers" })

-- ######## PLUGINS  ########

vim.pack.add({
    {src = "https://github.com/github/copilot.vim"}
})

vim.pack.add({
    {src = "https://github.com/nvim-mini/mini.pick"}
})
require"mini.pick".setup()
vim.keymap.set("n", "<leader>b", ":Pick buffers<CR>", { desc = "Opened buffers" })
vim.keymap.set("n", "<leader>f", ":Pick files<CR>", { desc = "Find file" })
vim.keymap.set("n", "<leader>'", ":Pick resume<CR>", { desc = "Open last picker" })
vim.keymap.set("n", "<leader>g", ":Pick grep_live<CR>", { desc = "Open live grep" })

vim.pack.add({
    {src = "https://github.com/junegunn/vim-easy-align"}
})
vim.keymap.set("x", "ga", "<Plug>(EasyAlign)", { desc = "Align selection" })

vim.pack.add({
    {src = "https://github.com/lewis6991/gitsigns.nvim"}
})
require("gitsigns").setup({
  current_line_blame = true, 
})
vim.keymap.set("n", "]g", function() require("gitsigns").nav_hunk("next") end, { desc = "Next hunk" })
vim.keymap.set("n", "[g", function() require("gitsigns").nav_hunk("prev") end, { desc = "Prev hunk" })

vim.pack.add({
    {src = "https://github.com/stevearc/oil.nvim"}
})
require"oil".setup({
  columns = { "icon" },
  keymaps = {
    ["-"] = "actions.parent",
  },
  view_options = {
      show_hidden = true,
  },
})
vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" } )

vim.pack.add({
    {src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master"}
})
require"nvim-treesitter.configs".setup({
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "m",
        node_incremental = "m",
        node_decremental = "<S-m>",
      },
    },
})
