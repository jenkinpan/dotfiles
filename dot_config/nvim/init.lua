local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- import vim setting and keymappings
require("core.keymaps")
require("core.options")
require("core.neovide")

-- import plugins, and the file location is `nvim/lua/plugins`
require("lazy").setup({ import = "plugins" }, {
	pkg = {
		enabled = true,
		cache = vim.fn.stdpath("state") .. "/lazy/pkg-cache.lua",
		-- the first package source that is found for a plugin will be used.
		sources = {
			"lazy",
			"rockspec", -- will only be used when rocks.enabled is true
			"packspec",
		},
	},
	rocks = {
		enabled = true,
		root = vim.fn.stdpath("data") .. "/lazy-rocks",
		server = "https://nvim-neorocks.github.io/rocks-binaries/",
	},
	checkers = {
		enabled = true,
		concurrency = nil, ---@type number? set to 1 to check for updates very slowly
		notify = true, -- get a notification when new updates are found
		frequency = 3600, -- check for updates every hour
		check_pinned = false, -- check for pinned packages that can't be updated
	},
})
