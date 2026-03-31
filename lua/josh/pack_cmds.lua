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
	local f, err = io.open(vim.fn.stdpath("config") .. "/nvim-pack-lock.json", "r")
	if f == nil then
		return {}, err
	end
	local pack_lock = Lib.json.decode(f:read("*a"))
	f:close()
	return pack_lock, nil
end

local pack_list_dispatcher = { ---@type { [string]: fun(): nil }
	pretty = function() vim.pack.update(nil, { offline = true }) end,
	inactive = function()
		local packs = {}
		for _, pack in ipairs(vim.pack.get()) do
			if not pack.active then
				packs[#packs + 1] = pack.spec.name
			end
		end
		packs_to_window(packs)
	end,
	all = function()
		local pack_lock, err = get_packages_fast()
		if err ~= nil then
			vim.notify("Could not open package lockfile:\n" .. err, vim.log.levels.ERROR)
			packs_to_window(vim.tbl_map(function(pack) return pack.spec.name end, vim.pack.get()))
			return
		end
		packs_to_window(vim.tbl_keys(pack_lock.plugins))
	end,
}

vim.api.nvim_create_user_command(
	"PackList",
	function(args) (pack_list_dispatcher[args.fargs[1]] or pack_list_dispatcher.all)() end,
	{
		complete = function() return vim.tbl_keys(pack_list_dispatcher) end,
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
	desc = "Delete installed packages from disk. -f to force",
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
	desc = "Update installed packages. -l to use lockfile",
})
