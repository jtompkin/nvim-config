---@class Pack
---@field active boolean
---@field branches string[]
---@field path string
---@field rev string
---@field spec vim.pack.SpecResolved
---@field tags? string[]

---@alias error string? String describing error or `nil`

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
---@type table<string, fun(): nil>
local pack_list_dispatcher = {
	pretty = function() vim.pack.update(nil, { offline = true }) end,
	inactive = function()
		local packs = {}
		for _, pack in ipairs(vim.pack.get()) do
			if not pack.active then
				packs[#packs + 1] = pack.spec.name
			end
		end
		Lib.show_list_in_window(packs, "No packages to show")
	end,
	all = function()
		local msg = "No packages to show"
		local pack_lock, err = get_packages_fast()
		if err ~= nil then
			vim.notify("Could not open package lockfile:\n" .. err, vim.log.levels.ERROR)
			Lib.show_list_in_window(vim.tbl_map(function(pack) return pack.spec.name end, vim.pack.get()), msg)
			return
		end
		Lib.show_list_in_window(vim.tbl_keys(pack_lock.plugins), msg)
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
