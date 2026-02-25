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

-- ######## LANGS    ########

local json_group = vim.api.nvim_create_augroup("JsonLocalOpts", { clear = true })
vim.api.nvim_create_autocmd({ "FileType", "WinEnter" }, {
  group = json_group,
  callback = function(args)
    if vim.bo[args.buf].filetype ~= "json" then
      return
    end
    local bo = vim.bo[args.buf]
    bo.expandtab = true
    bo.shiftwidth = 2
    bo.softtabstop = 2
  end,
})

local go_group = vim.api.nvim_create_augroup("GoLocalOpts", { clear = true })
vim.api.nvim_create_autocmd({ "FileType", "WinEnter" }, {
  group = go_group,
  callback = function(args)
    if vim.bo[args.buf].filetype ~= "go" then
      return
    end
    vim.wo.colorcolumn = "120"
  end,
})

local c_group = vim.api.nvim_create_augroup("CLocalOpts", { clear = true })
vim.api.nvim_create_autocmd({ "FileType", "WinEnter" }, {
  group = c_group,
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if ft ~= "c" and ft ~= "h" then
      return
    end
    vim.wo.colorcolumn = "80"
  end,
})

local lua_group = vim.api.nvim_create_augroup("LuaLocalOpts", { clear = true })
vim.api.nvim_create_autocmd({ "FileType", "WinEnter" }, {
  group = lua_group,
  callback = function(args)
    if vim.bo[args.buf].filetype ~= "lua" then
      return
    end
    local bo = vim.bo[args.buf]
    bo.expandtab = true
    bo.shiftwidth = 2
    bo.softtabstop = 2
    vim.wo.colorcolumn = "80"
  end,
})

local yaml_group = vim.api.nvim_create_augroup("YamlLocalOpts", { clear = true })
vim.api.nvim_create_autocmd({ "FileType", "WinEnter" }, {
  group = yaml_group,
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if ft ~= "yaml" and ft ~= "yml" then
      return
    end
    local bo = vim.bo[args.buf]
    bo.expandtab = true
    bo.shiftwidth = 2
    bo.softtabstop = 2
  end,
})

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

vim.pack.add({ {src = "https://github.com/github/copilot.vim"} })

vim.pack.add({ {src = "https://github.com/junegunn/vim-easy-align"} })
vim.keymap.set("x", "ga", "<Plug>(EasyAlign)", { desc = "Align selection" })

vim.pack.add({{src = "https://github.com/nvim-mini/mini.icons"}})
require"mini.icons".setup()

vim.pack.add({ {src = "https://github.com/nvim-mini/mini.pick"} })
require"mini.pick".setup()
local silentium_colors = require"silentium".colors
local apply_minipick_highlights = function()
  vim.api.nvim_set_hl(0, "MiniPickMatchRanges", { link = "CurSearch" })
  vim.api.nvim_set_hl(0, "MiniPickMatchCurrent", { bg = "#B3D7FF", fg = silentium_colors.dark })
end
apply_minipick_highlights()
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("MiniPickHighlightOverrides", { clear = true }),
  callback = apply_minipick_highlights,
})
vim.keymap.set("n", "<leader>b", ":Pick buffers<CR>", { desc = "Opened buffers" })
vim.keymap.set("n", "<leader>f", ":Pick files<CR>", { desc = "Find file" })
vim.keymap.set("n", "<leader>'", ":Pick resume<CR>", { desc = "Open last picker" })
vim.keymap.set("n", "<leader>/", ":Pick grep_live<CR>", { desc = "Open live grep" })

vim.pack.add({ {src = "https://github.com/lewis6991/gitsigns.nvim"} })
require"gitsigns".setup({
  current_line_blame = true, 
})
vim.keymap.set("n", "]g", function() require"gitsigns".nav_hunk("next") end, { desc = "Next hunk" })
vim.keymap.set("n", "[g", function() require"gitsigns".nav_hunk("prev") end, { desc = "Prev hunk" })

vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/NeogitOrg/neogit" },
})
require"neogit".setup()
vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<CR>", { desc = "Open Neogit" })

vim.pack.add({ {src = "https://github.com/stevearc/oil.nvim"} })
require"oil".setup({
  columns = { "icon" },
  keymaps = {
    ["-"] = "actions.parent",
    ["<C-h>"] = false,
    ["<C-j>"] = false,
    ["<C-k>"] = false,
    ["<C-l>"] = false,
  },
  view_options = {
    show_hidden = true,
  },
})
vim.keymap.set("n", "-", require"oil".open, { desc = "Open parent directory" } )

vim.pack.add({ {src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master"} })
local parser_install_dir = vim.fn.stdpath("data") .. "/site"
vim.opt.runtimepath:prepend(parser_install_dir)
require"nvim-treesitter.configs".setup({
  parser_install_dir = parser_install_dir,
  ensure_installed = {
    "lua",
    "vim",
    "vimdoc",
    "query",
    "bash",
    "python",
    "javascript",
    "typescript",
    "tsx",
    "json",
    "yaml",
    "toml",
    "go",
    "c",
    "cpp",
    "markdown",
    "markdown_inline",
  },
  auto_install = true,
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

vim.pack.add({{src = "https://github.com/nvim-treesitter/nvim-treesitter-context"}})
require"treesitter-context".setup({
    enable = true,
    multiwindow = false,      -- Enable multiwindow support.
    max_lines = 5,            -- How many lines the window should span. Values <= 0 mean no limit.
    min_window_height = 0,    -- Show in any window height.
    line_numbers = true,
    multiline_threshold = 20, -- Maximum number of lines to show for a single context
    trim_scope = "outer",     -- Which context lines to discard if `max_lines` is exceeded. Choices: "inner", "outer"
    mode = "cursor",          -- Line used to calculate context. Choices: "cursor", "topline"
    zindex = 20,              -- The Z-index of the context window
    on_attach = nil,          -- (fun(buf: integer): boolean) return false to disable attaching
    -- Separator between context and content. Should be a single character string, like "-".
    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    separator = "-",
})

vim.pack.add({
  {src = "https://github.com/hrsh7th/nvim-cmp"},
  {src = "https://github.com/hrsh7th/cmp-buffer"},
  {src = "https://github.com/hrsh7th/cmp-path"},
})
local cmp = require"cmp"
cmp.setup({
  sources = {
    { name = "buffer" },
    { name = "path"},
  },
  preselect = cmp.PreselectMode.Item,
  completion = {
    completeopt = "menu,menuone,noinsert",
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item({
      behavior = cmp.SelectBehavior.Insert,
    }),
    ["<C-n>"] = cmp.mapping.select_next_item({
      behavior = cmp.SelectBehavior.Insert,
    }),
    ["<C-k>"] = cmp.mapping.scroll_docs(-4),
    ["<C-j>"] = cmp.mapping.scroll_docs(4),

    ["<TAB>"] = cmp.mapping(function(fallback)
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
    entries = "native",
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = ({
        buffer   = "[Buffer]",
        path     = "[Path]",
      })[entry.source.name]
      return vim_item
    end
  },
})
