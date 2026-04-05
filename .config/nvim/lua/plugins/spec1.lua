return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    },
  },
  {
    "nvim-tree/nvim-tree.lua"
  },
  {
    "nvim-tree/nvim-web-devicons"
  },
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- optional but recommended
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    }
  }
}
