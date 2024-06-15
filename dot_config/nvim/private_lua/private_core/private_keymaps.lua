vim.g.mapleader = " " -- set <space> key as leader key
vim.g.maplocalleader = "," -- set <space> key as local leader key

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Keymaps
-- Allow clipboard copy paste in neovim
-- map("", "<C-v>", "+p<CR>", opts)
-- map("!", "<C-v>", "<C-R>+", opts)
-- map("t", "<C-v>", "<C-R>+", opts)
-- map("v", "<C-v>", "<C-R>+", opts)

-- Open Lazy
map("n", "<leader>L", "<cmd>Lazy <CR>", { desc = "Open Lazy" })

-- Open Mason
map("n", "<leader>M", "<cmd>Mason <CR>", { desc = "Open Mason" })

-- cancel highlight search result for /
map("n", "<leader>n", "<cmd>noh<CR>", { desc = "Cancel Search highlight" })

-- Toggle Symbols Outline
map("n", "<leader>lo", "<cmd>Lspsaga outline<CR>", { desc = "Open Outline" })
map("n", "<leader>lf", "<cmd>Lspsaga finder<cr>", { desc = "Find References" })
map("n", "<leader>lr", "<cmd>Lspsaga rename<cr>", { desc = "Rename" })

vim.keymap.set("n", "zM", "<cmd>lua require('ufo').closeAllFolds()<CR>", opts)
-- set KeyBind for BufferLine
map("n", "<leader>bp", "<cmd>BufferLinePick <CR>", { desc = "Go to Picked Buffer" }) -- go to a specific buffer
map("n", "<leader>bc", "<cmd>BufferLinePickClose <CR>", { desc = "Close picked buffer" }) -- close a specific buffer
map("n", "<leader>bo", "<cmd>BufferLineCloseOthers <CR>", { desc = "Close other buffers" }) -- close other buffers

-- set choose buffer by cycle next
map("n", "<leader><tab>", "<cmd>BufferLineCycleNext <CR>", { desc = "Buffer Cycle Next" })

-- set choose buffer by number
map("n", "<leader>b1", "<cmd>BufferLineGoToBuffer 1 <CR>", { desc = "Go to buffer 1" })
map("n", "<leader>b2", "<cmd>BufferLineGoToBuffer 2 <CR>", { desc = "Go to buffer 2" })
map("n", "<leader>b3", "<cmd>BufferLineGoToBuffer 3 <CR>", { desc = "Go to buffer 3" })
map("n", "<leader>b4", "<cmd>BufferLineGoToBuffer 4 <CR>", { desc = "Go to buffer 4" })
map("n", "<leader>b5", "<cmd>BufferLineGoToBuffer 5 <CR>", { desc = "Go to buffer 5" })

-- Navigate vim panes better
map("n", "<c-k>", "<cmd>wincmd k<CR>", opts)
map("n", "<c-j>", "<cmd>wincmd j<CR>", opts)
map("n", "<c-h>", "<cmd>wincmd h<CR>", opts)
map("n", "<c-l>", "<cmd>wincmd l<CR>", opts)

-- set terminal toggle
map("n", "<leader>`", "<cmd>Lspsaga term_toggle<CR>", opts)
map("t", "<leader>`", [[<cmd>Lspsaga term_toggle<CR>]], opts)
-- set shortcut for Neotree
map("n", "<C-n>", "<cmd>NvimTreeFindFile<CR>", opts)

-- set shortcut for LSP
map("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "Code Action" })

-- set dismiss noice message
map("n", "<leader>ds", "<cmd>NoiceDismiss<CR>", opts)

-- Git Stuffs keymaps
-- set get preview code with gitsigns
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk <CR>", opts)
-- open LazyGit
map("n", "<leader>gg", "<cmd>LazyGit<CR>", opts)
-- open Telescope git repos
map("n", "<leader>gr", function()
	require("telescope").extensions.lazygit.lazygit()
end, opts)

-- set telescope keymaps
map("n", "<leader>fb", "<cmd>Telescope buffers <CR>", opts)
map("n", "<leader>fh", "<cmd>Telescope help_tags <CR>", opts)
map("n", "<leader>ff", "<cmd>Telescope find_files <CR>", opts)
map("n", "<leader>fg", "<cmd>Telescope live_grep <CR>", opts)

-- debugging keymaps
map("n", "<leader>dt", "<cmd>DapToggleBreakpoint <CR>", { desc = "Toggle Breakpoint" })
map("n", "<leader>dc", "<cmd>DapContinue <CR>", { desc = "Dap Continue" })

-- UndoTree keymaps
map("n", "<leader>ut", "<cmd>UndotreeToggle <CR>", { desc = "Toggle UndoTree" })
map("n", "<leader>uf", "<cmd>UndotreeFocus <CR>", { desc = "Focus on UndoTree" })

-- Trouble keymaps
map("n", "<leader>xx", function()
	require("trouble").toggle()
end, { desc = "Toggle Trouble" }) -- Toggle Trouble
map("n", "<leader>xw", function()
	require("trouble").toggle("workspace_diagnostics")
end, { desc = "Toggle Workspace Trouble" }) -- Toggle Workspace Trouble
map("n", "<leader>xd", function()
	require("trouble").toggle("document_diagnostics")
end, { desc = "Toggle Document Trouble" }) -- Toggle Document Trouble
map("n", "<leader>xq", function()
	require("trouble").toggle("quickfix")
end, { desc = "Toggle Quickfix Trouble" }) -- Toggle Quickfix Trouble
map("n", "<leader>xl", function()
	require("trouble").toggle("loclist")
end, { desc = "Toggle Loclist Trouble" }) -- Toggle Loclist Trouble
map("n", "gR", function()
	require("trouble").toggle("lsp_references")
end, { desc = "Toggle LSP References" }) -- Toggle LSP References

-- Zoxide
map("n", "<leader>Z", function()
	require("telescope").extensions.zoxide.list()
end, { desc = "Zoxide" })

-- Neorg keymaps
-- metadata
map("n", "<localleader>im", "<cmd>Neorg inject-metadata<CR>", { desc = "[neorg] Inject Metadata" })
map("n", "<localleader>u", "<cmd>Neorg update-metadata<CR>", { desc = "[neorg] Update Metadata" })
-- table of contents
map("n", "<localleader>c", "<cmd>Neorg toc<CR>", { desc = "[neorg] Table of Contents" })
-- journal
map("n", "<localleader>jc", "<cmd>Neorg journal toc<CR>", { desc = "[neorg] Journal Table of Contents" })
map("n", "<localleader>jC", "<cmd>Neorg journal custom<CR>", { desc = "[neorg] New Journal Custom" })
map("n", "<localleader>jt", "<cmd>Neorg journal today<CR>", { desc = "[neorg] Journal Today" })
map("n", "<localleader>jT", "<cmd>Neorg journal tomorrow<CR>", { desc = "[neorg] Journal Tomorrow" })
map("n", "<localleader>jy", "<cmd>Neorg journal yesterday<CR>", { desc = "[neorg] Journal Yesterday" })
-- todo tasks
map(
	"n",
	"<localleader>ta",
	"<cmd>lua require('neorg.core').qol.todo_items.todo.task_ambiguous()<CR>",
	{ desc = "[neorg] Mark as ambiguous" }
)
map(
	"n",
	"<localleader>tc",
	"<cmd>lua require('neorg.core').qol.todo_items.todo.task_cancelled()<CR>",
	{ desc = "[neorg] Mark as cancelled" }
)
map(
	"n",
	"<localleader>td",
	"<cmd>lua require('neorg.core').qol.todo_items.todo.task_done()<CR>",
	{ desc = "[neorg] Mark as done" }
)
map(
	"n",
	"<localleader>th",
	"<cmd>lua require('neorg.core').qol.todo_items.todo.task_on_hold()<CR>",
	{ desc = "[neorg] Mark as on hold" }
)
map(
	"n",
	"<localleader>ti",
	"<cmd>lua require('neorg.core').qol.todo_items.todo.task_important()<CR>",
	{ desc = "[neorg] Mark as important" }
)
map(
	"n",
	"<localleader>tp",
	"<cmd>lua require('neorg.core').qol.todo_items.todo.task_pending()<CR>",
	{ desc = "[neorg] Mark as pending" }
)
map(
	"n",
	"<localleader>tr",
	"<cmd>lua require('neorg.core').qol.todo_items.todo.task_recurring()<CR>",
	{ desc = "[neorg] Mark as recurring" }
)
map(
	"n",
	"<localleader>tu",
	"<cmd>lua require('neorg.core').qol.todo_items.todo.task_undone()<CR>",
	{ desc = "[neorg] Mark as undone" }
)

-- Export markdown file
map("n", "<localleader>ef", "<cmd>Neorg export to-file<CR>", { desc = "[neorg] Export tofile" })
map("n", "<localleader>ed", "<cmd>Neorg export directory<CR>", { desc = "[neorg] Export to directory" })

-- Codeium keymaps
vim.keymap.set("i", "<tab>", function()
	return vim.fn["codeium#Accept"]()
end, { expr = true, silent = true })
vim.keymap.set("i", "<c-.>", function()
	return vim.fn["codeium#CycleCompletions"](1)
end, { expr = true, silent = true })
vim.keymap.set("i", "<c-,>", function()
	return vim.fn["codeium#CycleCompletions"](-1)
end, { expr = true, silent = true })
vim.keymap.set("i", "<c-x>", function()
	return vim.fn["codeium#Clear"]()
end, { expr = true, silent = true })

-- toggle showing inlay_hint
map("n", "<leader>hh", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle Inlay Hints" })

-- toggle highlight-color
map("n", "<leader>hc", "<cmd>HighlightColors Toggle<CR>", { desc = "Toggle HighlightColors" })