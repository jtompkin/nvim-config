-- This plugin is lazy-loaded
-- Optional: load nvim-cmp before this plugin for capabilities
Lib.pack_add_on_event(
	"FileType",
	vim.iter({
		"neovim/nvim-lspconfig",
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
	})
		:map(Lib.from_gh)
		:totable(),
	function()
		require("mason").setup()
		local ok, capabilities = pcall(function()
			return require("cmp_nvim_lsp").default_capabilities()
		end)
		if ok then
			vim.lsp.config("*", {
				capabilities = capabilities,
			})
		end
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
		require("mason-lspconfig").setup({
			ensure_installed = { "lua_ls", "pyright", "gopls" },
			automatic_enable = {
				exclude = { "stylua" },
			},
		})
	end,
	{ pattern = { "lua", "python", "go", "gomod", "gowork", "gotmpl" } }
)
