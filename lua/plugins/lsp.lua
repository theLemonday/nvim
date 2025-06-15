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

					{ path = "snacks.nvim", words = { "Snacks" } },
				},
			},
			dependencies = {
				"justinsgithub/wezterm-types",
			},
		},
		"b0o/schemastore.nvim",
		"saghen/blink.cmp",
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
						require("schema-companion.matchers.kubernetes").setup({
							version = "master",
						}),
					},
					schemas = {},
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

				-- The following two autocommands are used to highlight references of the
				-- word under your cursor when your cursor rests there for a little while.
				--    See `:help CursorHold` for information about when this is executed
				--
				-- When you move your cursor, the highlights will be cleared (the second autocommand).
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if
					client
					and client:supports_method(
						vim.lsp.protocol.Methods.textDocument_documentHighlight,
						event.buf
					)
				then
					local highlight_augroup =
						vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup(
							"kickstart-lsp-detach",
							{ clear = true }
						),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({
								group = "kickstart-lsp-highlight",
								buffer = event2.buf,
							})
						end,
					})
				end

				-- The following code creates a keymap to toggle inlay hints in your
				-- code, if the language server you are using supports them
				--
				-- This may be unwanted, since they displace some of your code
				if
					client
					and client:supports_method(
						vim.lsp.protocol.Methods.textDocument_inlayHint,
						event.buf
					)
				then
					map(
						"<leader>th",
						function()
							vim.lsp.inlay_hint.enable(
								not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
							)
						end,
						"[T]oggle Inlay [H]ints"
					)
				end
			end,
		})

		vim.lsp.config("*", {
			root_markers = { ".git" },
		})

		local ensure_installed = {
			"ansiblels",
			-- "basedpyright",
			"pylsp",
			"dockerls",
			"gopls",
			"jsonls",
			"lua_ls",
			"nil_ls",
			-- "sqlls",
			-- "templ",
			"terraformls",
			"yamlls",
			"ruff",
			"tinymist",
			"harper_ls",
		}
		vim.lsp.enable(ensure_installed)
	end,
}
