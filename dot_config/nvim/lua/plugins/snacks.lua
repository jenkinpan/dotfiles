return {
	"folke/snacks.nvim",
	opts = {
		-- enable snakes.image
		image = { enable = true },
		terminal = {
			enable = true,
			win = {
				-- make the terminal float
				position = "float",
				backdrop = 60,
				height = 0.7,
				width = 0.7,
				border = "rounded",
				zindex = 50,
			},
		},
	},
}
