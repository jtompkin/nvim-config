---@class Pack
---@field active boolean
---@field branches string[]
---@field path string
---@field rev string
---@field spec vim.pack.SpecResolved
---@field tags? string[]

---@alias error string? String describing error or `nil`

local function packs_to_window(packs) ---@param packs string[]
	if #packs == 0 then
		vim.notify("No packages to show")
		return
	end
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, packs)
	vim.keymap.set("n", "q", vim.cmd.q, { buffer = buf })
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "win",
		row = 0,
		col = 3,
		height = #packs,
		width = math.max(unpack(vim.tbl_map(function(pack) return #pack end, packs))) + 4 + math.floor(
			math.log10(#packs)
		),
		style = "minimal",
	})
	vim.api.nvim_set_option_value("number", true, { scope = "local", win = win })
end

---@return table val Decoded nvim-pack-lock.json file
---@return error err Any error that occurred while parsing file
local function get_packages_fast()
	if not Lib.json then
		return {}, "JSON library not loaded in Lib"
	end
	local f, err = io.open("nvim-pack-lock.json", "r")
	if not f then
		return {}, err
	end
	local pack_lock = Lib.json.decode(f:read("*a"))
	f:close()
	return pack_lock, nil
end

local list_dispatcher = { ---@type { [string]: fun(): nil }
	pretty = function() vim.pack.update(nil, { offline = true }) end,
	inactive = function()
		packs_to_window(
			vim.tbl_map(
				function(pack) return pack.spec.name end,
				vim.tbl_filter(function(pack) return not pack.active end, vim.pack.get())
			)
		)
	end,
	all = function()
		local function fallback()
			packs_to_window(vim.tbl_map(function(pack) return pack.spec.name end, vim.pack.get()))
		end
		local pack_lock, err = get_packages_fast()
		if not err then
			packs_to_window(vim.tbl_keys(pack_lock.plugins))
		else
			vim.notify("Could not open package lockfile:\n" .. err, vim.log.levels.ERROR)
			fallback()
		end
	end,
}

vim.api.nvim_create_user_command(
	"PackList",
	function(args) (list_dispatcher[args.fargs[1]] or list_dispatcher.all)() end,
	{
		complete = function() return vim.tbl_keys(list_dispatcher) end,
		nargs = "?",
		desc = "List installed packages",
	}
)

vim.api.nvim_create_user_command("PackDelete", function(args)
	local opts = {}
	if args.fargs[1] == "-f" then
		opts.force = true
		args.fargs = { unpack(args.fargs, 2) }
	end
	vim.pack.del(args.fargs, opts)
end, {
	nargs = "+",
	complete = function() return vim.list_extend(vim.tbl_keys(get_packages_fast().plugins or {}), { "-f" }) end,
	desc = "Delete installed packages from disk",
})

vim.api.nvim_create_user_command("PackUpdate", function(args)
	local opts = {}
	if args.fargs[1] == "-l" then
		opts.target = "lockfile"
		args.fargs = { unpack(args.fargs, 2) }
	end
	local packs
	if #args.fargs > 0 then
		packs = args.fargs
	end
	vim.pack.update(packs, opts)
end, {
	nargs = "*",
	complete = function() return vim.list_extend(vim.tbl_keys(get_packages_fast().plugins or {}), { "-l" }) end,
	desc = "Update installed packages",
})
