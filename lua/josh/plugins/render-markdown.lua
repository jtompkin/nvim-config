vim.pack.add({ Lib.from_gh("MeanderingProgrammer/render-markdown.nvim") })
local render_markdown = require("render-markdown")
render_markdown.setup({})
vim.keymap.set("n", "<leader>mp", render_markdown.preview, { desc = "Render markdown preview" })
