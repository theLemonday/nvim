return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		opts = {
			ensure_installed = "all",
			-- Autoinstall languages that are not installed
			auto_install = true,
			sync_install = false,
			highlight = {
				enable = true,
				-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
				--  If you are experiencing weird indenting issues, add the language to
				--  the list of additional_vim_regex_highlighting and disabled languages for indent.
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true },
			context_commentstring = {
				enable = true,
				enable_autocmd = false, -- important! mini.comment handles it
			},
		},
	},
	{ "towolf/vim-helm", ft = "helm" },
	{
		"windwp/nvim-ts-autotag",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function() require("nvim-ts-autotag").setup() end,
	},
}
