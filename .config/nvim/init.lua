vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "gd", vim.lsp.buf.definition)

require("config.lazy")
require("nvim-tree").setup()

vim.lsp.enable({ "lua_ls", "clangd", "bashls", "rust_analyzer" })

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true
})
