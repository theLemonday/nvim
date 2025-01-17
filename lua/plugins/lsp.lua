return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					-- See the configuration section for more details
					-- Load luvit types when the `vim.uv` word is found
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },

					-- Load the wezterm types when the `wezterm` module is required
					-- Needs `justinsgithub/wezterm-types` to be installed
					{ path = "wezterm-types", mods = { "wezterm" } },
				},
			},
			dependencies = {
				"justinsgithub/wezterm-types",
			},
		},

		"b0o/schemastore.nvim",
		"saghen/blink.cmp",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		--  This function gets run when an LSP attaches to a particular buffer.
		--    That is to say, every time a new file is opened that is associated with
		--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
		--    function will be executed to configure the current buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				-- NOTE: Remember that Lua is a real programming language, and as such it is possible
				-- to define small helper and utility functions so you don't have to repeat yourself.
				--
				-- In this case, we create a function that lets us more easily define mappings specific
				-- for LSP related items. It sets the mode, buffer and description for us each time.
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- Jump to the definition of the word under your cursor.
				--  This is where a variable was first declared, or where a function is defined, etc.
				--  To jump back, press <C-t>.
				-- map("gd", require("fzf-lua").lsp_definitions, "[G]oto [D]efinition")

				-- Find references for the word under your cursor.
				-- map("gr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")

				-- Jump to the implementation of the word under your cursor.
				--  Useful when your language has ways of declaring types without an actual implementation.
				-- map("gI", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")

				-- Jump to the type of the word under your cursor.
				--  Useful when you're not sure what type a variable is and you want to see
				--  the definition of its *type*, not where it was *defined*.
				-- map("<leader>D", require("fzf-lua").lsp_typedefs, "Type [D]efinition")

				-- Fuzzy find all the symbols in your current document.
				--  Symbols are things like variables, functions, types, etc.
				-- map("<leader>ds", require("fzf-lua").lsp_document_symbols, "[D]ocument [S]ymbols")

				-- Fuzzy find all the symbols in your current workspace.
				--  Similar to document symbols, except searches over your entire project.
				-- map("<leader>ws", require("fzf-lua").lsp_live_workspace_symbols, "[W]orkspace [S]ymbols")

				-- Rename the variable under your cursor.
				--  Most Language Servers support renaming across files, etc.
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

				-- Execute a code action, usually your cursor needs to be on top of an error
				-- or a suggestion from your LSP for this to activate.
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

				-- Opens a popup that displays documentation about the word under your cursor
				--  See `:help K` for why this keymap.
				map("K", vim.lsp.buf.hover, "Hover Documentation")

				-- WARN: This is not Goto Definition, this is Goto Declaration.
				--  For example, in C this would take you to the header.
				-- map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				-- The following two autocommands are used to highlight references of the
				-- word under your cursor when your cursor rests there for a little while.
				--    See `:help CursorHold` for information about when this is executed
				--
				-- When you move your cursor, the highlights will be cleared (the second autocommand).
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.server_capabilities.documentHighlightProvider then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				-- The following code creates a keymap to toggle inlay hints in your
				-- code, if the language server you are using supports them
				--
				-- This may be unwanted, since they displace some of your code
				if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				"golines",
				"djlint",
				"yamlfix",
				"ansiblels",
				"gopls",
				"gofumpt",
				"goimports",
				"stylua",
				"lua-language-server",
				"hadolint",
				"eslint",
				"sql-formatter",
				"typescript-language-server",
				"svelte-language-server",
				"prettierd",
				"nixpkgs-fmt",
				-- "tailwindcss-language-server",
				"buf",
				"sqlls",
				-- "pyright",
				"ruff",
				"shfmt",
				"python-lsp-server",
				"nil",
				"templ",
			},
		})

		local servers = {
			templ = {},
			lua_ls = {},
			jsonls = {
				settings = {
					json = {
						schemas = require("schemastore").json.schemas({
							extra = {
								{
									description = "App script config file",
									name = "appsscript.json",
									fileMatch = { "appsscript.json" },
									url = "https://json.schemastore.org/appsscript",
								},
								{
									description = "Clasp config file",
									name = ".clasp.json",
									fileMatch = { ".clasp.json" },
									url = "https://json.schemastore.org/clasp",
								},
							},
						}),
						validate = { enable = true },
					},
				},
			},
			yamlls = {
				settings = {
					yaml = {
						schemaStore = {
							-- You must disable built-in schemaStore support if you want to use
							-- this plugin and its advanced options like `ignore`.
							enable = false,
							-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
							url = "",
						},
						schemas = require("schemastore").yaml.schemas(),
					},
				},
			},
			dockerls = {},
			terraformls = {},
			pylsp = {
				settings = {
					pylsp = {
						plugins = {
							ruff = {
								enabled = true, -- Enable the plugin
								formatEnabled = true, -- Enable formatting using ruffs formatter
								-- executable = "<path-to-ruff-bin>", -- Custom path to ruff
								-- config = "<path_to_custom_ruff_toml>", -- Custom config for ruff to use
								extendSelect = { "I" }, -- Rules that are additionally used by ruff
								extendIgnore = { "C90" }, -- Rules that are additionally ignored by ruff
								format = { "I" }, -- Rules that are marked as fixable by ruff that should be fixed when running textDocument/formatting
								severities = { ["D212"] = "I" }, -- Optional table of rules where a custom severity is desired
								unsafeFixes = false, -- Whether or not to offer unsafe fixes as code actions. Ignored with the "Fix All" action

								-- Rules that are ignored when a pyproject.toml or ruff.toml is present:
								lineLength = 88, -- Line length to pass to ruff checking and formatting
								exclude = { "__about__.py" }, -- Files to be excluded by ruff checking
								select = { "F" }, -- Rules to be enabled by ruff
								ignore = { "D210" }, -- Rules to be ignored by ruff
								perFileIgnores = {
									["__init__.py"] = "CPY001",
								}, -- Rules that should be ignored for specific files
								preview = false, -- Whether to enable the preview style linting and formatting.
								targetVersion = "py310", -- The minimum python version to target (applies for both linting and formatting).
							},
						},
					},
				},
			},
			ruff = {},
			nil_ls = {},
			sqlls = {},
			gopls = {
				settings = {
					gopls = {
						gofumpt = true,
						codelenses = {
							gc_details = false,
							generate = true,
							regenerate_cgo = true,
							run_govulncheck = true,
							test = true,
							tidy = true,
							upgrade_dependency = true,
							vendor = true,
						},
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
						analyses = {
							-- fieldalignment = true,
							nilness = true,
							unusedparams = true,
							unusedwrite = true,
							useany = true,
						},
						usePlaceholders = true,
						completeUnimported = true,
						staticcheck = true,
						directoryFilters = {
							"-.git",
							"-.vscode",
							"-.idea",
							"-.vscode-test",
							"-node_modules",
						},
						semanticTokens = true,
					},
				},
			},
		}
		vim.lsp.config("*", {
			root_markers = { ".git" },
		})
		-- vim.lsp.enable("gopls")
		-- vim.lsp.enable("lua_ls")

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local config = servers[server_name] or {}
					-- passing config.capabilities to blink.cmp merges with the capabilities in your
					-- `opts[server].capabilities, if you've defined it
					config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
					require("lspconfig")[server_name].setup(config)
				end,
			},
		})
	end,
}
