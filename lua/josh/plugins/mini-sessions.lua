vim.pack.add({ Lib.from_gh("nvim-mini/mini.sessions") })
local mini_sessions = require("mini.sessions")
mini_sessions.setup()
vim.keymap.set(
	"n",
	"<leader>sw",
	function() mini_sessions.write(mini_sessions.config.file) end,
	{ desc = "Write local session" }
)
vim.keymap.set("n", "<leader>sn", function()
	local session = vim.fn.input("Session name: ")
	if session ~= "" then
		mini_sessions.write(session)
	end
end, { desc = "Write new session" })
vim.keymap.set("n", "<leader>sr", mini_sessions.read, { desc = "Read default session" })
vim.keymap.set("n", "<leader>ps", mini_sessions.select, { desc = "Pick sessions" })
