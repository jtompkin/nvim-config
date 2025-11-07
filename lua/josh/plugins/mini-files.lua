vim.pack.add({ Lib.from_gh("nvim-mini/mini.files") })
require("mini.files").setup({})
vim.keymap.set("n", "<leader>pv", MiniFiles.open, { desc = "Return to file exporer" })
