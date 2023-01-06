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
					work = "~/notes/work",
					home = "~/notes/home",
                    example_gtd = "/mnt/d/git-repo/github/neorg-gtd-example_workspaces"
				},
			},
		},
		["core.presenter"] = {
			config = {
				zen_mode = "zen-mode",
			},
		},
		["core.gtd.base"] = {
			config = {
				workspace = "example_gtd",
			},
		},
		["core.norg.completion"] = {
			config = {
				engine = "nvim-cmp",
			},
		},
		["core.norg.concealer"] = {},
	},
})
