local lib = require("key/lib")

local TERMINAL = "com.superlogical.terminal"
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
local function get_cwd(ctx)
	local p, perr = rex.block.call(TERMINAL, "pwd", { block_id = ctx and ctx.block_id })
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

		local layer, err = lib.open_float({
			command = { "lazygit" },
			cwd = get_cwd(ctx),
			bounds = { 0.04, 0.04, 0.92, 0.88 },
			label = LAZYGIT_LABEL,
		})
		if err ~= nil then
			error(err, 0)
		end
		return layer
	end,
})

rex.bind("ctrl+shift+g", "lazygit_float")
