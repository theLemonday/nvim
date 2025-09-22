return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			fish = { "fish_indent" },
			lua = { "stylua" },
			go = { "goimports", "gofumpt", "golines" },
			terraform = { "terraform_fmt" },
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
			typescriptreact = { "prettierd" },
			vue = { "prettierd" },
			sql = { "sql_formatter" },
			-- sql = { "sqlfluff" },
			bash = { "shfmt" },
			yaml = { "yamlfix" },
			graphql = { "prettierd" },
			css = { "prettierd" },
			-- jinja = { "djlint" },
			html = { "prettierd" },
			templ = { "templ" },
			json = { "prettierd" },
			jsonc = { "prettierd" },
			markdown = { "prettierd" },
			groovy = { "npm-groovy-lint" },
			caddyfile = { "caddy_fmt" },
			r = { "styler" },
			cpp = { "clang_format" },
			c = { "clang_format" },
		},
		format_on_save = function(bufnr)
			local max_lines = 5000
			local line_count = vim.api.nvim_buf_line_count(bufnr)
			if line_count > max_lines then
				return -- Do not format this buffer
			end
			return { timeout_ms = 2000, lsp_fallback = true }
		end,
		formatters = {
			caddy_fmt = {
				command = "caddy",
				args = { "fmt", "-" },
			},
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
			["npm-groovy-lint"] = {
				prepend_args = { "--fix" },
			},
		},
	},
}
