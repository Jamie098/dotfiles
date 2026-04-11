-- Options
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.wo.relativenumber = true
vim.g.mapleader = " "

-- Disable netrw (using nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Completion
vim.o.autocomplete = true
vim.o.completeopt = 'menu,menuone,popup'

-- Plugins
require("config.lazy")
require("nvim-tree").setup()
local builtin = require('telescope.builtin')
local harpoon = require("harpoon")
harpoon:setup()

-- LSP
vim.lsp.enable({ "lua_ls", "clangd", "bashls", "rust_analyzer" })


vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true
})

-- Keymaps: Navigation
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "gd", vim.lsp.buf.definition)

-- Keymaps: Telescope
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Keymaps: Harpoon
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<C-j>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-m>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)

-- Keymaps: Completion
vim.keymap.set('i', '<C-Enter>', function()
  if vim.fn.pumvisible() == 1 then
    return '<C-n><C-y>'
  else
    return '<C-Enter>'
  end
end, { expr = true })
