rex.action({
	name = "btop_float",
	title = "Floating btop",
	run = function(ctx, args)
		local layer, err = rex.session.new_layer({
			bounds = { 0.1, 0.1, 0.8, 0.8 },
			focus = true,
			layout = rex.layout.block({
				flavor = "com.superlogical.terminal.shell",
				options = {
					command = { "btop" },
				},
			}),
		})
		if err ~= nil then
			error(err, 0)
		end
	end,
})

rex.bind("cmd+shift+b", "btop_float")
