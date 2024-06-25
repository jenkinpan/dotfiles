return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {},
	config = function()
		local wk = require("which-key")
		wk.setup({
			plugins = {
				spelling = {
					enabled = true,
					suggestions = 20,
				},
			},
		})

		wk.register({
			["<leader>"] = {
				["`"] = { "<cmd>Lspsaga term_toggle<cr>", "Toggle Terminal" },
				b = {
					name = "Buffers",
				},
				c = {
					name = "Code Actions",
				},
				d = {
					name = "Debug",
				},
				f = {
					name = "Telescope",
				},
				g = {
					name = "Git Stuffs",
				},
				l = {
					name = "Lspsaga",
				},
				u = {
					name = "Undo Tree",
				},
				x = {
					name = "Trouble",
				},
			},
			[","] = {
				e = {
					name = "[neorg] Export",
				},
				t = {
					name = "[neorg] Todo Tasks",
				},
				i = {
					name = "[neorg] Insert",
				},
				j = {
					name = "[neorg] Journal",
				},
				l = {
					name = "[neorg] List",
				},
				m = {
					name = "[neorg] Mode",
				},
				n = {
					name = "[neorg] New",
				},
			},
		})

		wk.register({
			["<leader>"] = {
				c = { name = "Codesnap" },
			},
		}, { mode = "v" })
	end,
}
