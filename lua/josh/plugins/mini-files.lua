vim.pack.add({ Lib.from_gh("nvim-mini/mini.files") })
require("mini.files").setup()
vim.keymap.set("n", "<leader>pV", MiniFiles.open, { desc = "Return to file exporer" })
vim.keymap.set("n", "<leader>pv", function()
	MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
	MiniFiles.reveal_cwd()
end, { desc = "Open file explorer to current file" })
vim.api.nvim_create_autocmd("User", {
	group = vim.api.nvim_create_augroup("minifiles", {}),
	pattern = "MiniFilesBufferCreate",
	callback = function(args)
		local b = args.data.buf_id
		vim.keymap.set("n", "gy", function()
			local path = (MiniFiles.get_fs_entry() or {}).path
			if path == nil then
				return vim.notify("Cursor is not on valid entry")
			end
			vim.fn.setreg(vim.v.register, path)
		end, { buffer = b, desc = "Yank path" })
		vim.keymap.set(
			"n",
			"gX",
			function() vim.ui.open(MiniFiles.get_fs_entry().path) end,
			{ buffer = b, desc = "Open with default OS handler" }
		)
	end,
})
