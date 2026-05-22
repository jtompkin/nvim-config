vim.pack.add({ Lib.from_gh("esmuellert/codediff.nvim"), Lib.from_gh("NeogitOrg/neogit") })
local neogit = require("neogit")
neogit.setup({
	mappings = {
		finder = {
			["<C-j>"] = "Next",
			["<C-k>"] = "Previous",
		},
	},
})
vim.keymap.set("n", "<leader>gs", neogit.open, { desc = "Open git integration" })
