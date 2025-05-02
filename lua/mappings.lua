require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
pcall(vim.keymap.del, "n", "<leader>gg")
map("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })
