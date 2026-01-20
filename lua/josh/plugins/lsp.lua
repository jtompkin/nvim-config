-- Optional: load nvim-cmp before this plugin for capabilities
vim.pack.add(vim.iter({
	"neovim/nvim-lspconfig",
	"mason-org/mason.nvim",
	"mason-org/mason-lspconfig.nvim",
})
	:map(Lib.from_gh)
	:totable())
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
				version = "LuaJIT",
				-- Tell the language server how to find Lua modules same way as Neovim
				-- (see `:h lua-module-load`)
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
	settings = {
		Lua = {},
	},
})
vim.lsp.config("powershell_es", {
	on_attach = function(client) client.server_capabilities.semanticTokensProvider = nil end,
	settings = {
		powershell = {
			codeFormatting = {
				preset = "OTBS",
				whitespaceBeforeOpenBrace = true,
				whitespaceAroundOperator = true,
				whitespaceAroundPipe = true,
				trimWhitespaceAroundPipe = true,
			},
		},
	},
})
local ok, capabilities = pcall(function() return require("cmp_nvim_lsp").default_capabilities() end)
if ok then
	vim.lsp.config("*", { capabilities = capabilities })
end
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls" },
	automatic_enable = {
		exclude = { "stylua" },
	},
})
