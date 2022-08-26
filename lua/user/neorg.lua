local status_ok, neorg = pcall(require, "neorg")
if not status_ok then
	return
end
neorg.setup({
	load = {
		["core.defaults"] = {},
		["core.norg.dirman"] = {
			config = {
				workspaces = {
					work = os.getenv("HOME") .. "/notes/work",
					home = os.getenv("HOME") .. "/notes/home",
					all = os.getenv("HOME") .. "/notes/org",
				},
			},
		},
		["core.norg.completion"] = {
			config = {
				-- Configuration here
				engine = "nvim-cmp",
			},
		},
		["core.norg.concealer"] = {
			config = { -- Note that this table is optional and doesn't need to be provided
				-- Configuration here
			},
		},
		["core.gtd.base"] = {
			config = { -- Note that this table is optional and doesn't need to be provided
				-- Configuration here
				workspace = "home"
			},
		},
	},
})
