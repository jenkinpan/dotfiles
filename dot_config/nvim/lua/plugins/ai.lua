return {
	{ -- A free AI code-completion engine
		"Exafunction/codeium.nvim",
		event = "InsertEnter",
		config = function()
			require("codeium").setup({
				enable_chat = true,
			})
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		lazy = true,
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},
}
