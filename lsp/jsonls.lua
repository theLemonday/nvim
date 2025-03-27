return {
	settings = {
		json = {
			schemas = require("schemastore").json.schemas({
				extra = {
					{
						description = "App script config file",
						name = "appsscript.json",
						fileMatch = { "appsscript.json" },
						url = "https://json.schemastore.org/appsscript",
					},
					{
						description = "Clasp config file",
						name = ".clasp.json",
						fileMatch = { ".clasp.json" },
						url = "https://json.schemastore.org/clasp",
					},
				},
			}),
			validate = { enable = true },
		},
	},
}
