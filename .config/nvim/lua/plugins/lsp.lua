return {
  { "neovim/nvim-lspconfig" },
  {
    "mason-org/mason.nvim",
    opts = {}
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = { "lua_ls", "clangd", "bashls" },
    },
  },
}
