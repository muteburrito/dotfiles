-- This is a basic nvim config file

-- ========================================
-- Basic Options
-- ========================================
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- =======================================
-- Key Bindings
-- =======================================
vim.keymap.set("n", "<leader>r", ":source ~/.config/nvim/init.lua<CR>")
