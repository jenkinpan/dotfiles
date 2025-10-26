-- Keymaps are automatically loaded on the VeryLazy event
-- Add any additional keymaps here
local map = vim.keymap.set
-- set navagation between vim and tmux panes
map("n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Navigate to left pane", remap = true })
map("n", "<c-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Navigate to lower pane", remap = true })
map("n", "<c-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Navigate to upper pane", remap = true })
map("n", "<c-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Navigate to right pane", remap = true })
