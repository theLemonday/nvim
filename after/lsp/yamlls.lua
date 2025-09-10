return {
	override = function(config) return require("schema-companion").setup_client(config) end,
	-- Have to add this for yamlls to understand that we support line folding
	capabilities = {
		textDocument = {
			foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			},
		},
	},
	-- lazy-load schemastore when needed
	on_new_config = function(new_config)
		new_config.settings.yaml.schemas = vim.tbl_deep_extend(
			"force",
			new_config.settings.yaml.schemas or {},
			require("schemastore").yaml.schemas()
		)
	end,
	settings = {
		redhat = { telemetry = { enabled = false } },
		yaml = {
			keyOrdering = false,
			format = {
				enable = true,
			},
			validate = true,
			schemas = {
				kubernetes = "k8s-*.yaml",
				["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
				["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
				["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/**/*.{yml,yaml}",
				["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
				["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
				["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
				["http://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}",
			},
			-- schemaStore = {
			-- 	-- Must disable built-in schemaStore support to use
			-- 	-- schemas from SchemaStore.nvim plugin
			-- 	enable = false,
			-- 	-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
			-- 	url = "",
			-- },
		},
	},
}
