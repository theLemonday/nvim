vim.filetype.add({
	extension = { templ = "templ", env = "sh", service = "systemd", http = "http" },
	pattern = {

		-- [".*/templates/.*%.tpl"] = "helm",
		-- [".*/templates/.*%.ya?ml"] = "helm",
		-- ["helmfile.*%.ya?ml"] = "helm",

		[".*/defaults/.*%.ya?ml"] = "yaml.ansible",
		[".*/host_vars/.*%.ya?ml"] = "yaml.ansible",
		[".*/group_vars/.*%.ya?ml"] = "yaml.ansible",
		[".*/group_vars/.*/.*%.ya?ml"] = "yaml.ansible",
		[".*/playbook.*%.ya?ml"] = "yaml.ansible",
		[".*/playbooks/.*%.ya?ml"] = "yaml.ansible",
		[".*/roles/.*/tasks/.*%.ya?ml"] = "yaml.ansible",
		[".*/roles/.*/handlers/.*%.ya?ml"] = "yaml.ansible",
		[".*/tasks/.*%.ya?ml"] = "yaml.ansible",
		[".*/molecule/.*%.ya?ml"] = "yaml.ansible",

		["Caddyfile.*"] = "caddyfile",

		["%.env%.[%w_.-]+"] = "sh",
	},
	filename = {
		-- ["justfile"] = "make",
		-- ["Justfile"] = "make",
		[".pre-commit-config.yaml"] = "yaml.pre-commit",

		["Caddyfile"] = "caddyfile",

		[".env"] = "sh",
	},
})
