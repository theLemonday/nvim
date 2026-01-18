return {
	{
		"saghen/blink.compat",
		-- use the latest release, via version = '*', if you also use the latest release for blink.cmp
		version = "*",
		-- lazy.nvim will automatically load the plugin when it's required by blink.cmp
		lazy = true,
		-- make sure to set opts so that lazy.nvim calls blink.compat's setup
		opts = {},
	},
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = {
			{ "samiulsami/cmp-go-deep", dependencies = { "kkharji/sqlite.lua" } },
			{ "rafamadriz/friendly-snippets" },
			{
				"L3MON4D3/LuaSnip",
				-- follow latest release.
				version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
				-- install jsregexp (optional!).
				build = "make install_jsregexp",
			},
		},

		-- use a release tag to download pre-built binaries
		version = "*",
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = {
				preset = "default",
				["<A-1>"] = { function(cmp) cmp.accept({ index = 1 }) end },
				["<A-2>"] = { function(cmp) cmp.accept({ index = 2 }) end },
				["<A-3>"] = { function(cmp) cmp.accept({ index = 3 }) end },
				["<A-4>"] = { function(cmp) cmp.accept({ index = 4 }) end },
				["<A-5>"] = { function(cmp) cmp.accept({ index = 5 }) end },
				["<A-6>"] = { function(cmp) cmp.accept({ index = 6 }) end },
				["<A-7>"] = { function(cmp) cmp.accept({ index = 7 }) end },
				["<A-8>"] = { function(cmp) cmp.accept({ index = 8 }) end },
				["<A-9>"] = { function(cmp) cmp.accept({ index = 9 }) end },
				["<A-0>"] = { function(cmp) cmp.accept({ index = 10 }) end },
			},

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = {
					"lazydev",
					"lsp",
					"path",
					"snippets",
					"buffer",
					-- "markdown",
				},
				per_filetype = {
					sql = { "snippets", "dadbod", "buffer" },
				},
				providers = {
					dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
					go_deep = {
						name = "go_deep",
						module = "blink.compat.source",
						min_keyword_length = 3,
						max_items = 5,
						---@module "cmp_go_deep"
						---@type cmp_go_deep.Options
						opts = {
							-- See below for configuration options
						},
					},
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
					markdown = {
						name = "RenderMarkdown",
						module = "render-markdown.integ.blink",
						fallbacks = { "lsp" },
					},
				},
				-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
				-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
				-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
				--
				-- See the fuzzy documentation for more information
				-- fuzzy = { implementation = "prefer_rust_with_warning" },
			},

			completion = {
				ghost_text = { enabled = true },
				menu = {
					draw = {
						columns = {
							{ "item_idx" },
							-- { "kind_icon" },
							{ "label", "label_description", gap = 1 },
							{ "kind" },
						},
						components = {
							item_idx = {
								text = function(ctx)
									return ctx.idx == 10 and "0"
										or ctx.idx >= 10 and " "
										or tostring(ctx.idx)
								end,
								highlight = "BlinkCmpItemIdx", -- optional, only if you want to change its color
							},
							-- kind_icon = {
							-- 	text = function(ctx)
							-- 		local kind_icon, _, _ =
							-- 			require("mini.icons").get("lsp", ctx.kind)
							-- 		return kind_icon
							-- 	end,
							-- 	-- (optional) use highlights from mini.icons
							-- 	highlight = function(ctx)
							-- 		local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
							-- 		return hl
							-- 	end,
							-- },
							kind = {
								-- text = function(ctx)
								-- 	return "[" .. string.sub(ctx.kind, 1, 3) .. "]"
								-- end,
								-- (optional) use highlights from mini.icons
								highlight = function(ctx)
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
									return hl
								end,
							},
						},
					},
				},
				documentation = {
					-- (Default) Only show the documentation popup when manually triggered
					auto_show = false,
				},
			},
		},
		opts_extend = { "sources.default" },
	},
}
