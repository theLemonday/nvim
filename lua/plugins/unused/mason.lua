local ensure_installed = {
	"json-lsp",
	"templ",
	"clang-format",
	"helm-ls",
}
return {
	"mason-org/mason-lspconfig.nvim",
	opts = {
		ensure_installed,
		automatic_enable = {
			exclude = {
				"rust_analyzer",
				"ts_ls",
			},
		},
	},
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
}
