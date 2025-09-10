local autoSaveExcludedFiletypess = { "oil" }
local group = vim.api.nvim_create_augroup("autosave", {})

vim.api.nvim_create_autocmd("User", {
	pattern = "AutoSaveWritePost",
	group = group,
	callback = function(opts)
		if opts.data.saved_buffer ~= nil then
			local filename = vim.fn.expand("%:t")

			vim.notify("Auto saved " .. filename, vim.log.levels.INFO)
		end
	end,
})

return {
	"okuuva/auto-save.nvim",
	version = "^1.0.0", -- see https://devhints.io/semver, alternatively use '*' to use the latest tagged release
	cmd = "ASToggle", -- optional for lazy loading on command
	event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
	opts = {
		condition = function(buf)
			local fn = vim.fn
			local utils = require("auto-save.utils.data")

			-- don't save for file types
			if utils.not_in(fn.getbufvar(buf, "&filetype"), autoSaveExcludedFiletypess) then
				return true
			end
			return false
		end,
		debouce_delay = 2000,
	},
}
