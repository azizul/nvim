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

--TODO prefer to put this whichkey or custom user function
-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

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
	})

	-- GUI
	use({ "kyazdani42/nvim-web-devicons" })
	use({ "kyazdani42/nvim-tree.lua" })
	use({ "akinsho/bufferline.nvim" })
	use({ "nvim-lualine/lualine.nvim" })
	use({ "akinsho/toggleterm.nvim" })
	use({ "ahmedkhalf/project.nvim" })
	use({ "goolord/alpha-nvim" })
	use({ "folke/which-key.nvim" })
	use({ "rcarriga/nvim-notify" })

	-- general utility
	use({ "moll/vim-bbye" }) -- improve BDelete
	use({ "MattesGroeger/vim-bookmarks" })
	use({ "nvim-telescope/telescope.nvim" }) -- fuzzy finder
	use({ "tom-anders/telescope-vim-bookmarks.nvim" })
	use({ "max397574/better-escape.nvim" }) -- faster mapping for escape

	-- motion, text manipulation
	use({ "lukas-reineke/indent-blankline.nvim" })
	use({ "numToStr/Comment.nvim" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring" })
	use({ "windwp/nvim-autopairs" }) -- Autopairs, integrates with both cmp and treesitter
	use({ "phaazon/hop.nvim" }) -- move around buffer
	use({ "junegunn/vim-easy-align" }) -- Aligning text on symbol or expression
	use({ "kylechui/nvim-surround" })
	use({ "nacro90/numb.nvim" }) -- peeking via :xx command
	use({ "monaqa/dial.nvim" }) -- increment & decrement

	-- Colorschemes
	use({ "lunarvim/darkplus.nvim" })
	use({ "bluz71/vim-moonfly-colors" })

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
	use({ "nvim-orgmode/orgmode" })

	----------------------
	-- Code development --
	----------------------
	-- SCM
	use({ "lewis6991/gitsigns.nvim" }) -- Git

	-- CODE COMPLETIONS/GUIDE
	-- cmp plugins
	use({ "hrsh7th/nvim-cmp" }) -- The completion plugin
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

	-- DEBUGGING
	-- nvim-dap
	use({ "mfussenegger/nvim-dap" })
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
