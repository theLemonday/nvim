-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		"tpope/vim-sleuth",
		"tpope/vim-eunuch",

		{
			"ellisonleao/gruvbox.nvim",
			enabled = false,
			priority = 1000,
			opts = {
				transparent_mode = true,
				dim_inactive = true,
			},
			init = function()
				vim.o.background = "dark" -- or "light" for light mode
				vim.cmd([[colorscheme gruvbox]])
			end,
		},

		{
			"folke/tokyonight.nvim",
			enabled = false,
			lazy = true,
			priority = 1000,
			opts = {
				transparent = true,
			},
			init = function() vim.cmd([[colorscheme tokyonight]]) end,
		},
		{
			"catppuccin/nvim",
			enabled = false,
			name = "catppuccin",
			priority = 1000,
			opts = { transparent_background = true },
			init = function() vim.cmd.colorscheme("catppuccin") end,
		},

		-- import your plugins
		{ import = "plugins" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "catppuccin" } },
	-- automatically check for plugin updates
	checker = { enabled = true, notify = false },

	performance = {
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
	dev = {
		path = "~/code/neovim-plugins",
	},
	change_detection = {
		enabled = true,
		notify = true,
	},
})
