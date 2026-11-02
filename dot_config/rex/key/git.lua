local TERMINAL = "com.superlogical.terminal"
local SHELL = "com.superlogical.terminal.shell"
local LAZYGIT_LABEL = "lazygit"

local function url_to_path(u)
	if type(u) ~= "string" or u:sub(1, 7) ~= "file://" then
		return u -- 已经是普通路径或未知形式，原样返回
	end
	local path = u:gsub("^file://[^/]*", "")
	path = path:gsub("%%(%x%x)", function(h)
		return string.char(tonumber(h, 16))
	end)
	return path
end

-- 取当前终端所在目录（出错时抛出）
local function get_cwd()
	local p, perr = rex.block.call(TERMINAL, "pwd", {})
	if p == nil then
		error("pwd failed: " .. tostring(perr), 0)
	end
	if p.pwd == nil or p.pwd == "" then
		error("no cwd, pwd returned: " .. rex.json.encode(p), 0)
	end
	return url_to_path(p.pwd)
end

-- 在会话里找已经打开的 lazygit 块（按标签），返回 block 与 layer
local function find_lazygit()
	local view, err = rex.session.view({})
	if err ~= nil or view == nil or view.windows == nil then
		return nil
	end
	for _, w in ipairs(view.windows) do
		for _, l in ipairs(w.layers or {}) do
			for _, b in ipairs(l.blocks or {}) do
				if b.label == LAZYGIT_LABEL then
					return { block_id = b.block_id, layer_id = l.layer_id }
				end
			end
		end
	end
	return nil
end

-- 在新 tab 里跑一条 git 命令，跑完保留输出
local function open_git_tab(title, argv)
	local cwd = get_cwd()
	local w, err = rex.session.new_window({
		window_label = title,
		layout = rex.layout.block({
			flavor = SHELL,
			options = { command = argv, cwd = cwd, exit = { on_completion = false } },
		}),
	})
	if err ~= nil then
		error(err, 0)
	end
	return { window_id = w.window_id }
end

rex.action({
	name = "lazygit_float",
	title = "Lazygit",
	description = "在浮动层打开 lazygit；已打开则置顶并聚焦。",
	category = "Git",
	run = function(ctx, args)
		-- 已存在 → 置顶 + 聚焦，而不是再开一个
		local existing = find_lazygit()
		if existing ~= nil then
			if existing.layer_id ~= nil then
				rex.session.raise_layer({ layer_id = existing.layer_id })
			end
			local _, ferr = rex.session.focus_block({ block_id = existing.block_id })
			if ferr ~= nil then
				error(ferr, 0)
			end
			return { focused = existing.block_id }
		end

		local cwd = get_cwd()
		local layer, err = rex.session.new_layer({
			bounds = { 0.04, 0.04, 0.92, 0.88 },
			focus = true,
			layout = rex.layout.block({
				flavor = SHELL,
				options = { command = { "lazygit" }, cwd = cwd },
			}),
		})
		if err ~= nil then
			error(err, 0)
		end

		local bid = layer.block_ids and layer.block_ids[1]
		if bid ~= nil then
			rex.session.set_block_label({ block_id = bid, label = LAZYGIT_LABEL })
		end
		return layer
	end,
})

rex.action({
	name = "git_log",
	title = "Git Log",
	description = "新 tab 显示 git log（最近 20 条）。",
	category = "Git",
	run = function()
		return open_git_tab("git log", { "git", "--no-pager", "log", "--oneline", "--decorate", "-20" })
	end,
})

rex.action({
	name = "git_diff",
	title = "Git Diff",
	description = "新 tab 显示 git diff（未暂存的改动）。",
	category = "Git",
	run = function()
		return open_git_tab("git diff", { "git", "--no-pager", "diff" })
	end,
})

rex.action({
	name = "git_status",
	title = "Git Status",
	description = "新 tab 显示 git status。",
	category = "Git",
	run = function()
		return open_git_tab("git status", { "git", "--no-pager", "status" })
	end,
})

-- 快速路径：直接开 lazygit 浮层
rex.bind("ctrl+shift+g", "lazygit_float")

-- git 模式：cmd+g 进入，模式里 g/l/d/s 触发命令，esc 退出
rex.mode("git", { exclusive = true })
rex.bind("cmd+g", "client.mode.enter", { name = "git", once = true })
rex.bind("git/g", "lazygit_float")
rex.bind("git/l", "git_log")
rex.bind("git/d", "git_diff")
rex.bind("git/s", "git_status")
