vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

require("config.lazy")

vim.lsp.enable({ "lua_ls", "clangd" })
