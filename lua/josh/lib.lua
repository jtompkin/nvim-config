local lib = {}

local ok, json = pcall(require, "lib.json")
if ok then
	lib.json = json
end

lib.pack_add_group = vim.api.nvim_create_augroup("pack-add", {})

---@param event vim.api.keyset.events|vim.api.keyset.events[]
---@param specs (string|vim.pack.Spec)[]
---@param setup fun(): nil
---@param opts vim.api.keyset.create_autocmd?
function lib.pack_add_on_event(event, specs, setup, opts)
	vim.api.nvim_create_autocmd(
		event,
		vim.tbl_extend("force", opts or {}, {
			group = lib.pack_add_group,
			callback = function()
				vim.pack.add(specs)
				setup()
			end,
		})
	)
end

---@param v any Value to start piping
---@param fns (fun(v: any): any)[] List of functions to apply sequentially
---@return any v Return value of last function in `functions`
function lib.pipe(v, fns)
	for _, f in ipairs(fns) do
		v = f(v)
	end
	return v
end

---@param list string[]
---@param message string? Message to send to vim.notify when list is empty
function lib.show_list_in_window(list, message)
	if #list == 0 then
		if message then
			vim.notify(message)
		end
		return
	end
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, list)
	vim.keymap.set("n", "q", vim.cmd.q, { buffer = buf })
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "win",
		row = 0,
		col = 3,
		height = #list,
		width = math.max(unpack(vim.tbl_map(function(pack) return #pack end, list))) + 4 + math.floor(
			math.log10(#list)
		),
		style = "minimal",
	})
	vim.api.nvim_set_option_value("number", true, { scope = "local", win = win })
end

---@return boolean is_windows `true` if the current system is Windows
function lib.is_windows() return vim.uv.os_uname().sysname == "Windows_NT" end

---@param repo string Owner and repo name separated by "/"
---@return string url Full GitHub repo URL
function lib.from_gh(repo) return "https://github.com/" .. repo end

return lib
