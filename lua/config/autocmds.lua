-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function() vim.highlight.on_yank() end,
})

-- Relative number in normal mode
local augroup = vim.api.nvim_create_augroup("numbertoggle", {})

vim.api.nvim_create_autocmd(
	{ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" },
	{
		pattern = "*",
		group = augroup,
		callback = function()
			if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
				vim.opt.relativenumber = true
			end
		end,
	}
)

vim.api.nvim_create_autocmd(
	{ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" },
	{
		pattern = "*",
		group = augroup,
		callback = function()
			if vim.o.nu then
				vim.opt.relativenumber = false
				vim.cmd("redraw")
			end
		end,
	}
)

vim.api.nvim_create_autocmd(
	{ "BufWritePre" },
	{ pattern = { "*.templ" }, callback = vim.lsp.buf.format }
)

-- Jump to last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local line = mark[1]
		if line > 0 and line <= vim.api.nvim_buf_line_count(0) then vim.cmd('normal! g`"') end
	end,
})

local view_group = vim.api.nvim_create_augroup("auto_view", { clear = true })
vim.api.nvim_create_autocmd({ "BufWinLeave", "BufWritePost", "WinLeave" }, {
	desc = "Save view with mkview for real files",
	group = view_group,
	callback = function(args)
		if vim.b[args.buf].view_activated then vim.cmd.mkview({ mods = { emsg_silent = true } }) end
	end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	desc = "Try to load file view if available and enable view saving for real files",
	group = view_group,
	callback = function(args)
		if not vim.b[args.buf].view_activated then
			local filetype = vim.api.nvim_get_option_value("filetype", { buf = args.buf })
			local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
			local ignore_filetypes = { "gitcommit", "gitrebase", "svg", "hgcommit" }
			if
				buftype == ""
				and filetype
				and filetype ~= ""
				and not vim.tbl_contains(ignore_filetypes, filetype)
			then
				vim.b[args.buf].view_activated = true
				vim.cmd.loadview({ mods = { emsg_silent = true } })
			end
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "templ",
	callback = function() vim.treesitter.start() end,
})
