vim.pack.add({ Lib.from_gh("nvim-mini/mini.pick") })
require("mini.pick").setup({
	mappings = {
		move_down = "<C-j>",
		move_up = "<C-k>",
		toggle_preview = "<C-p>",
	},
})
vim.keymap.set("n", "<leader>pf", MiniPick.builtin.files, { desc = "Pick from files" })
vim.keymap.set("n", "<leader>pg", MiniPick.builtin.grep_live, { desc = "Pick from grep pattern in files" })
vim.keymap.set(
	"n",
	"<leader>pw",
	function() MiniPick.builtin.grep({ pattern = vim.fn.expand("<cword>") }) end,
	{ desc = "Pick from grep cword in files" }
)
vim.keymap.set(
	"n",
	"<leader>pW",
	function() MiniPick.builtin.grep({ pattern = vim.fn.expand("<cWORD>") }) end,
	{ desc = "Pick from grep cWORD in files" }
)
vim.keymap.set("n", "<leader>ph", MiniPick.builtin.help, { desc = "Pick from help" })
vim.keymap.set("n", "<leader>pr", MiniPick.builtin.resume, { desc = "Resume last picker" })
