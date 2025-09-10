vim.filetype.add({
	extension = {
		env = "sh",
	},
	filename = {
		[".env"] = "sh",
	},
	pattern = {
		["%.env%.[%w_.-]+"] = "sh",
	},
})
