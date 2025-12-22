vim.g.mkdp_echo_preview_url = 1
return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		heading = { position = "inline" },
		completions = { lsp = { enabled = true }, blink = { enabled = true } },
		preset = "obsidian",
		max_file_size = 10.0,
		render_modes = true,
	},
	{
		"obsidian-nvim/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		-- ft = "markdown",
		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		event = {
			-- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
			-- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
			-- refer to `:h file-pattern` for more examples
			"BufReadPre "
				.. vim.fn.expand("~")
				.. "/vaults/personal/*.md",
			"BufNewFile " .. vim.fn.expand("~") .. "/vaults/personal/*.md",
		},
		---@module 'obsidian'
		---@type obsidian.config
		opts = {
			legacy_commands = false,
			workspaces = {
				{
					name = "personal",
					path = "~/vaults/personal",
				},
				{
					name = "work",
					path = "~/vaults/work",
				},
			},
			ui = { enable = false },
			attachments = { img_folder = "/attachments" },
		},
	},
}
