local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
---@diagnostic disable-next-line: missing-parameter
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	snapshot_path = fn.stdpath("config") .. "/snapshots",
	max_jobs = 5,
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
		prompt_border = "rounded", -- Border style of prompt popups.
	},
	log = { level = "warn" }, -- The default print log level. One of: "trace", "debug", "info", "warn", "error", "fatal".
})

-- Install your plugins here
return packer.startup(function(use)
	-- Plugin manager
	use({ "wbthomason/packer.nvim" }) -- Have packer manage itself

	-- Lua development
	use({ "nvim-lua/plenary.nvim" }) -- Useful lua functions used by lots of plugins
	use({ "nvim-lua/popup.nvim" })
	use({ "christianchiarulli/lua-dev.nvim" })

	-- FIXME still in pull request not merged yet to neovim
	-- system improvement
	use({ "lewis6991/impatient.nvim" })

	-- highlighting
	use({
		"nvim-treesitter/nvim-treesitter",
		requires = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"p00f/nvim-ts-rainbow",
			"nvim-treesitter/playground",
		},
		config = require("user.plugin.config.treesitter"),
	})

	-- GUI
	use({ "kyazdani42/nvim-web-devicons" })
	use({ "kyazdani42/nvim-tree.lua", config = require("user.plugin.config.nvim-tree") })
	use({ "nvim-lualine/lualine.nvim", config = require("user.plugin.config.lualine") })
	use({ "akinsho/toggleterm.nvim", config = require("user.plugin.config.toggleterm") })
	use({ "ahmedkhalf/project.nvim", config = require("user.plugin.config.project") })
	use({ "goolord/alpha-nvim", config = require("user.plugin.config.alpha") })
	use({ "folke/which-key.nvim", config = require("user.plugin.config.whichkey") })
	use({ "rcarriga/nvim-notify", config = require("user.plugin.config.notify") })

    --FIXME need to manually call require "noice".setup() to start it
	use({
		"folke/noice.nvim",
		event = "VimEnter",
		config = require("user.plugin.config.noice"),
		requires = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	})
	-- general utility
	use({ "moll/vim-bbye" }) -- improve BDelete
	use({ "MattesGroeger/vim-bookmarks" })
	use({ "nvim-telescope/telescope.nvim", config = require("user.plugin.config.telescope") }) -- fuzzy finder
	use({ "tom-anders/telescope-vim-bookmarks.nvim" })
	use({ "max397574/better-escape.nvim", config = require("user.plugin.config.escape") }) -- faster mapping for escape

	-- motion, text manipulation
	use({ "lukas-reineke/indent-blankline.nvim", config = require("user.plugin.config.indentline") })
	use({ "numToStr/Comment.nvim", config = require("user.plugin.config.comment") })
	use({ "JoosepAlviste/nvim-ts-context-commentstring" })
	use({ "windwp/nvim-autopairs", config = require("user.plugin.config.autopairs") }) -- Autopairs, integrates with both cmp and treesitter
	use({ "phaazon/hop.nvim", config = require("user.plugin.config.hop") }) -- move around buffer
	use({ "junegunn/vim-easy-align" }) -- Aligning text on symbol or expression
	use({ "kylechui/nvim-surround", config = require("user.plugin.config.surround") })
	use({ "nacro90/numb.nvim", config = require("user.plugin.config.numb") }) -- peeking via :xx command
	use({ "monaqa/dial.nvim" }) -- increment & decrement

	-- Colorschemes
	use({ "bluz71/vim-moonfly-colors", config = require("user.plugin.config.colorscheme") }) -- active and loaded
	use({ "lunarvim/darkplus.nvim" }) -- not active

	-- Note taking
	-- TODO still need to figure out how to search
	-- FIXME break with 0.8
	--[[ use({ ]]
	--[[ 	"phaazon/mind.nvim", ]]
	--[[ 	branch = "v2.2", ]]
	--[[ 	requires = { "nvim-lua/plenary.nvim" }, ]]
	--[[ 	config = function() ]]
	--[[ 		require("mind").setup() ]]
	--[[ 	end, ]]
	--[[ }) ]]

	-- Orgmode port
	use({ "nvim-orgmode/orgmode", config = require("user.plugin.config.orgmode") })

	-- Color
	--[[ use({ ]]
	--[[ 	"ziontee113/color-picker.nvim", ]]
	--[[ 	config = function() ]]
	--[[ 		require("color-picker") ]]
	--[[ 	end, ]]
	--[[ }) ]]
	use({ "ziontee113/color-picker.nvim", config = require("user.plugin.config.colorpicker") })
	use({ "NvChad/nvim-colorizer.lua", config = require("user.plugin.config.colorizer") }) -- add color bg to certain keyword

	----------------------
	-- Code development --
	----------------------
	-- SCM
	use({ "lewis6991/gitsigns.nvim", config = require("user.plugin.config.gitsigns") }) -- Git

	-- CODE COMPLETIONS/GUIDE
	-- cmp plugins
	use({ "hrsh7th/nvim-cmp", config = require("user.plugin.config.cmp") }) -- The completion plugin
	use({ "hrsh7th/cmp-buffer" }) -- buffer completions
	use({ "hrsh7th/cmp-path" }) -- path completions
	use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-nvim-lua" })

	-- snippets
	use({ "L3MON4D3/LuaSnip" }) --snippet engine
	use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to use

	-- LSP
	use({ "neovim/nvim-lspconfig" }) -- enable LSP
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })
	use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters
	use({ "b0o/SchemaStore.nvim" })
	use({ "https://git.sr.ht/~whynothugo/lsp_lines.nvim", as = "lsp_lines" })
	use({ "simrat39/symbols-outline.nvim", config = require("user.plugin.config.symbol-outline") })
	use({ "SmiteshP/nvim-navic", config = require("user.plugin.config.navic") })
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = require("user.plugin.config.trouble"),
	})

	-- DEBUGGING
	-- nvim-dap
	use({ "mfussenegger/nvim-dap", config = require("user.plugin.config.dap") })
	use({ "rcarriga/nvim-dap-ui" })
	use({ "ravenxrz/DAPInstall.nvim" })
	use({ "mfussenegger/nvim-jdtls" }) -- java lsp and debugger
	use({ "jbyuki/one-small-step-for-vimkind" }) -- java lsp and debugger

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
