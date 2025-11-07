vim.pack.add({ Lib.from_gh("NeogitOrg/neogit"), Lib.from_gh("nvim-lua/plenary.nvim") })
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
