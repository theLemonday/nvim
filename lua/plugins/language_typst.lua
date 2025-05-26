return {
	"chomosuke/typst-preview.nvim",
	lazy = true,
	ft = "typst",
	version = "1.*",
	opts = {
		-- open_cmd = "zathura %s",
		dependencies_bin = {
			["tinymist"] = "tinymist",
			["websocat"] = "websocat",
		},
	},
}
