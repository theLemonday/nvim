return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			go = { "goimports", "gofumpt" },
			terraform = { "terraform_fmt" },
			tf = { "terraform_fmt" },
			["terraform-vars"] = { "terraform_fmt" },
			python = {
				"ruff_organize_imports",
				-- To fix lint errors.
				"ruff_fix",
				-- To run the Ruff formatter.
				"ruff_format",
			},
			nix = { "nixpkgs_fmt" },
			buf = { "buf" },
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			sql = { "sql_formatter" },
			bash = { "shfmt" },
			yaml = { "yamlfix" },
			graphql = { "prettierd" },
			css = { "prettierd" },
			jinja = { "djlint" },
			html = { "prettierd" },
			templ = { "templ" },
			json = { "prettierd" },
		},
		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 500,
			lsp_format = "fallback",
		},
		formatters = {
			yamlfix = {
				env = {
					YAMLFIX_WHITELINES = 1,
				},
			},
			sql_formatter = {
				prepend_args = {
					"--config",
					[[
				{
					"language": "sqlite",
					"keywordCase": "upper",
					"tabWidth": 4
				}
					]],
				},
			},
		},
	},
}
