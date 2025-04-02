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
		{
			"cenk1cenk2/schema-companion.nvim",
			dependencies = {
				{ "nvim-lua/plenary.nvim" },
				{ "nvim-telescope/telescope.nvim" },
			},
			config = function()
				require("schema-companion").setup({
					-- if you have telescope you can register the extension
					enable_telescope = true,
					matchers = {
						-- add your matchers
						require("schema-companion.matchers.kubernetes").setup({ version = "master" }),
					},
					schemas = {
						{
							name = "Kubernetes master",
							uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master-standalone-strict/all.json",
						},
					},
				})
			end,
		},
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
				if
					client
					and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
				then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
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
				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		local ensure_installed_tools = {
			"systemdlint",
			"markdownlint",
			"djlint",
			"yamlfix",
			"golines",
			"gofumpt",
			"goimports",
			"stylua",
			"hadolint",
			"eslint",
			"sql-formatter",
			"prettierd",
			"nixpkgs-fmt",
			"shfmt",
			"ansible-lint",
			"shellcheck",
			"dotenv-linter",
		}
		require("mason-tool-installer").setup({
			ensure_installed = ensure_installed_tools,
		})

		vim.lsp.config("*", {
			root_markers = { ".git" },
		})

		local ensure_installed = {
			"ansiblels",
			"basedpyright",
			"dockerls",
			"gopls",
			"jsonls",
			"lua_ls",
			"nil_ls",
			"pylsp",
			"sqlls",
			"templ",
			"terraformls",
			"yamlls",
		}
		vim.lsp.enable(ensure_installed)

		require("mason-lspconfig").setup({
			ensure_installed = ensure_installed,
			automatic_installation = true,
			handlers = {
				function(server_name)
					local lspconfig = require("lspconfig")
					local capabilities = require("blink.cmp").get_lsp_capabilities()

					lspconfig[server_name].setup({ capabilities = capabilities })
				end,
			},
		})
	end,
}
