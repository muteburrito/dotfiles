vim.keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit window" })
vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

vim.keymap.set("n", "<c-h>", "<c-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<c-j>", "<c-w>j", { desc = "Move to lower window" })
vim.keymap.set("n", "<c-k>", "<c-w>k", { desc = "Move to upper window" })
vim.keymap.set("n", "<c-l>", "<c-w>l", { desc = "Move to right window" })

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Line diagnostics" })
