return {
	settings = {
		basedpyright = {
			disableOrganizeImports = true,
			diagnosticSeverityOverrides = {
				reportMissingTypeAnnotation = "none",
			},
			python = {
				pythonPath = "./.venv/bin/python",
			},
		},
	},
}
