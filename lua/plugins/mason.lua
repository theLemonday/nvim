local function mason_package_path(package)
	local path = vim.fn.resolve(vim.fn.stdpath("data") .. "/mason/packages/" .. package)
	return path
end
return {
	{
		"williamboman/mason.nvim",
		init = function(_)
			local pylsp = require("mason-registry").get_package("python-lsp-server")
			pylsp:on("install:success", function()
				local path = mason_package_path("python-lsp-server")
				local command = path .. "/venv/bin/pip"
				local args = {
					"install",
					"-U",
					"pylsp-rope",
					-- "python-lsp-black",
					-- "python-lsp-isort",
					"python-lsp-ruff",
					-- "pyls-memestra",
					"pylsp-mypy",
				}

				require("plenary.job")
					:new({
						command = command,
						args = args,
						cwd = path,
					})
					:start()
			end)
		end,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			return { ensure_installed = { "lua_ls" } }
		end,
	},
}
