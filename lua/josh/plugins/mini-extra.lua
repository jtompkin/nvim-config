vim.pack.add({ Lib.from_gh("nvim-mini/mini.extra") })
local mini_extra = require("mini.extra")
mini_extra.setup()
vim.keymap.set("n", "<leader>pc", mini_extra.pickers.commands, { desc = "Pick from commands" })
vim.keymap.set("n", "<leader>pH", mini_extra.pickers.history, { desc = "Pick from history" })
vim.keymap.set("n", "<leader>pk", mini_extra.pickers.keymaps, { desc = "Pick from keymaps" })
vim.keymap.set(
	"n",
	"<leader>pj",
	function() mini_extra.pickers.list({ scope = "jump" }) end,
	{ desc = "Pick from jumplist" }
)
vim.keymap.set(
	"n",
	"<leader>plw",
	function() mini_extra.pickers.lsp({ scope = "workspace_symbol_live" }) end,
	{ desc = "Pick from workspace symbols" }
)
vim.keymap.set(
	"n",
	"<leader>pld",
	function() mini_extra.pickers.lsp({ scope = "document_symbol" }) end,
	{ desc = "Pick from document symbols" }
)
vim.api.nvim_create_user_command(
	"PickLsp",
	function(opts) mini_extra.pickers.lsp({ scope = opts.fargs[1] }) end,
	{
		nargs = 1,
		complete = function()
			return {
				"declaration",
				"definition",
				"document_symbol",
				"implementation",
				"references",
				"type_definition",
				"workspace_symbol",
				"workspace_symbol_live",
			}
		end,
	}
)
