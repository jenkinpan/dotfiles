local lib = require("key/lib")

rex.action({
	name = "btop_float",
	title = "Floating btop",
	run = function(ctx, args)
		local _, err = lib.open_float({
			command = { "btop" },
			bounds = { 0.1, 0.1, 0.8, 0.8 },
		})
		if err ~= nil then
			error(err, 0)
		end
	end,
})

rex.bind("cmd+shift+b", "btop_float")
