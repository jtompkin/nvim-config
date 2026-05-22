---@class Tmux
---@field prefix string
---@field shell string
vim.g.Tmux = {
	prefix = "<C-b>",
	shell = "pwsh",
}
vim.keymap.set(
	{ "n", "t" },
	vim.g.Tmux.prefix .. "c",
	function() vim.cmd("tabnew | startinsert | terminal " .. vim.g.Tmux.shell) end
)
vim.keymap.set({ "n", "t" }, vim.g.Tmux.prefix .. "X", vim.cmd.tabclose, { desc = "Close current tab-page" })
-- Tab switching
vim.keymap.set({ "n", "t" }, vim.g.Tmux.prefix .. "n", vim.cmd.tabnext, { desc = "Switch to next tab-page" })
vim.keymap.set(
	{ "n", "t" },
	vim.g.Tmux.prefix .. "N",
	function() vim.cmd("tabnext #") end,
	{ desc = "Switch to last accessed tab-page" }
)
vim.keymap.set({ "n", "t" }, vim.g.Tmux.prefix .. "p", vim.cmd.tabprevious, { desc = "Switch to previous tab-page" })
vim.keymap.set(
	{ "n", "t" },
	vim.g.Tmux.prefix .. "1",
	function() vim.cmd("tabnext 1") end,
	{ desc = "Switch to tab-page 1" }
)
vim.keymap.set(
	{ "n", "t" },
	vim.g.Tmux.prefix .. "2",
	function() vim.cmd("tabnext 2") end,
	{ desc = "Switch to tab-page 2" }
)
vim.keymap.set(
	{ "n", "t" },
	vim.g.Tmux.prefix .. "3",
	function() vim.cmd("tabnext 3") end,
	{ desc = "Switch to tab-page 3" }
)
vim.keymap.set(
	{ "n", "t" },
	vim.g.Tmux.prefix .. "4",
	function() vim.cmd("tabnext 4") end,
	{ desc = "Switch to tab-page 4" }
)
vim.keymap.set(
	{ "n", "t" },
	vim.g.Tmux.prefix .. "5",
	function() vim.cmd("tabnext 5") end,
	{ desc = "Switch to tab-page 5" }
)
vim.keymap.set(
	{ "n", "t" },
	vim.g.Tmux.prefix .. "6",
	function() vim.cmd("tabnext 6") end,
	{ desc = "Switch to tab-page 6" }
)
vim.keymap.set(
	{ "n", "t" },
	vim.g.Tmux.prefix .. "7",
	function() vim.cmd("tabnext 7") end,
	{ desc = "Switch to tab-page 7" }
)
vim.keymap.set(
	{ "n", "t" },
	vim.g.Tmux.prefix .. "8",
	function() vim.cmd("tabnext 8") end,
	{ desc = "Switch to tab-page 8" }
)
vim.keymap.set(
	{ "n", "t" },
	vim.g.Tmux.prefix .. "9",
	function() vim.cmd("tabnext 9") end,
	{ desc = "Switch to tab-page 9" }
)
vim.keymap.set(
	{ "n", "t" },
	vim.g.Tmux.prefix .. "0",
	function() vim.cmd("tabnext $") end,
	{ desc = "Switch to last tab-page" }
)
-- Tab moving
vim.keymap.set({ "n", "t" }, vim.g.Tmux.prefix .. ">", function() vim.cmd("+tabmove") end)
vim.keymap.set({ "n", "t" }, vim.g.Tmux.prefix .. "<", function() vim.cmd("-tabmove") end)

vim.keymap.set({ "n", "t" }, vim.g.Tmux.prefix .. "s", vim.cmd.tabs, { desc = "Show tab list" })
vim.keymap.set("t", "<C-b><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Window creation
vim.keymap.set({ "n", "t" }, vim.g.Tmux.prefix .. "-", vim.cmd.split, { desc = "Create horizontal window" })
vim.keymap.set({ "n", "t" }, vim.g.Tmux.prefix .. "_", function()
	vim.cmd("horizontal term " .. vim.g.Tmux.shell)
	vim.cmd.startinsert()
end, { desc = "Create horizontal terminal window" })
vim.keymap.set({ "n", "t" }, vim.g.Tmux.prefix .. "\\", vim.cmd.vsplit, { desc = "Create vertical window" })
vim.keymap.set({ "n", "t" }, vim.g.Tmux.prefix .. "|", function()
	vim.cmd("vertical term " .. vim.g.Tmux.shell)
	vim.cmd.startinsert()
end, { desc = "Create vertical terminal window" })

-- Window closing
vim.keymap.set({ "n", "t" }, vim.g.Tmux.prefix .. "x", vim.cmd.q, { desc = "Close window" })
