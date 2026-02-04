-- Optional: load nvim-cmp before this plugin for capabilities
vim.pack.add(
	vim.tbl_map(Lib.from_gh, { "neovim/nvim-lspconfig", "mason-org/mason.nvim", "mason-org/mason-lspconfig.nvim" })
)
require("mason").setup({})
vim.lsp.config("lua_ls", {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
				path ~= vim.fn.stdpath("config")
				and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
			then
				return
			end
		end
		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				version = "LuaJIT", -- Tell the language server how to find Lua modules same way as Neovim (see `:h lua-module-load`)
				path = {
					"lua/?.lua",
					"lua/?/init.lua",
				},
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
				},
			},
		})
	end,
	settings = { Lua = {} },
})
vim.lsp.config("powershell_es", {
	on_attach = function(client) client.server_capabilities.semanticTokensProvider = nil end,
	settings = {
		powershell = {
			codeFormatting = {
				preset = "OTBS",
				ignoreOneLineBlock = true,
				whitespaceBeforeOpenBrace = true,
				whitespaceAroundOperator = true,
				whitespaceAroundPipe = true,
				trimWhitespaceAroundPipe = true,
			},
		},
	},
})
vim.lsp.enable("basedpyright")
require("mason-lspconfig").setup({ automatic_enable = { exclude = { "stylua" } } })
