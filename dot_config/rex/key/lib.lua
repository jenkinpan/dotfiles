-- 共享工具：在浮动层里启动一个终端命令
local M = {}

M.SHELL = "com.superlogical.terminal.shell"

-- 打开一个浮动层运行 shell 命令，返回 layer；失败时返回 nil 与错误信息。
-- opts: command（程序与参数列表）、bounds（窗口内 [x, y, w, h] 比例）、
--       cwd（可选工作目录）、label（可选块标签）
function M.open_float(opts)
	local options = { command = opts.command }
	if opts.cwd ~= nil then
		options.cwd = opts.cwd
	end

	local layer, err = rex.session.new_layer({
		bounds = opts.bounds,
		focus = true,
		layout = rex.layout.block({
			flavor = M.SHELL,
			options = options,
		}),
	})
	if err ~= nil then
		return nil, err
	end

	if opts.label ~= nil then
		local bid = layer.block_ids and layer.block_ids[1]
		if bid ~= nil then
			rex.session.set_block_label({ block_id = bid, label = opts.label })
		end
	end

	return layer
end

return M
