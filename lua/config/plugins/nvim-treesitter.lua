return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = {
        "rust",
        "go",
        "lua",
        "vim",
        "vimdoc",
        "bash",
        "json",
        "yaml",
        "toml",
        "markdown",
        "markdown_inline",
        "python",
        "javascript",
        "typescript",
        "tsx",
        "html",
        "css",
      },
      auto_install = true,

      -- highlight = {
      --   enable = true,
      --   additional_vim_regex_highlighting = false,
      -- },

      indent = {
        enable = true,
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "m",
          node_incremental = "m",
          scope_incremental = "<C-m>",
          node_decremental = "<S-m>",
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
