-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

vim.opt.number = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = "unnamedplus"

if vim.fn.has("wsl") == 1 then
	vim.g.clipboard = {
		name = "WslClipboard",
		copy = {
			["+"] = "clip.exe",
			["*"] = "clip.exe",
		},
		paste = {
			["+"] = "powershell.exe -NoProfile -Command Get-Clipboard",
			["*"] = "powershell.exe -NoProfile -Command Get-Clipboard",
		},
		cache_enabled = false,
	}
else
	vim.g.clipboard = {
		name = "wl-clipboard",
		copy = {
			["+"] = "wl-copy",
			["*"] = "wl-copy",
		},
		paste = {
			["+"] = "wl-paste --no-newline",
			["*"] = "wl-paste --no-newline",
		},
		cache_enabled = 1,
	}

	-- vim.g.clipboard = {
	-- 	name = "xclip",
	-- 	copy = {
	-- 		["+"] = { "xclip", "-selection", "clipboard" },
	-- 		["*"] = { "xclip", "-selection", "primary" },
	-- 	},
	-- 	paste = {
	-- 		["+"] = { "xclip", "-selection", "clipboard", "-o" },
	-- 		["*"] = { "xclip", "-selection", "primary", "-o" },
	-- 	},
	-- 	cache_enabled = 0,
	-- }
end

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- A TAB character looks like 4 spaces
vim.o.tabstop = 4

vim.o.conceallevel = 2

-- Disable third party provider
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

vim.g.encoding = "Unicode"

vim.opt.cmdheight = 1
-- Enable spell check
-- vim.opt.spell = true
-- vim.opt.spelllang = { "en_us" }

local vietnameseKeyboard = "vietnamese-telex_utf-8"
vim.api.nvim_create_user_command("ToggleVietnameseKeyboard", function()
	if vim.o.keymap == vietnameseKeyboard then
		vim.o.keymap = nil
	else
		vim.o.keymap = vietnameseKeyboard
	end
end, {})

-- Diagnostics ================================================================
-- Conservative but useful diagnostic display

local diagnostic_opts = {
	-- Show signs only for warnings and errors, with high priority
	signs = {
		priority = 9999,
		severity = {
			min = vim.diagnostic.severity.WARN,
			max = vim.diagnostic.severity.ERROR,
		},
	},

	-- Underline all diagnostics
	underline = {
		severity = {
			min = vim.diagnostic.severity.HINT,
			max = vim.diagnostic.severity.ERROR,
		},
	},

	-- Virtual text only for errors on current line
	virtual_lines = false,
	virtual_text = {
		current_line = true,
		severity = {
			min = vim.diagnostic.severity.ERROR,
			max = vim.diagnostic.severity.ERROR,
		},
	},

	-- Don't update diagnostics while typing
	update_in_insert = false,
}

-- Apply after startup (safe with lazy.nvim)
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function() vim.diagnostic.config(diagnostic_opts) end,
})

-- vim.opt.scrolloff = 999
