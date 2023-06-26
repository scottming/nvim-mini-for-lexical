local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local lexical_config = {
	filetypes = { "elixir", "eelixir", "heex", "surface" },
	cmd = { "/Users/scottming/Code/lexical/_build/dev/rel/lexical/start_lexical.sh" },
	settings = {},
}

local custom_attach = function(client)
	print("Lexical has started.")
end

require("lazy").setup({
	"neovim/nvim-lspconfig",
	commit = "649137cbc53a044bffde36294ce3160cb18f32c7",
	-- lazy = true,
	config = function()
		local lspconfig = require("lspconfig")
		local configs = require("lspconfig.configs")

		if not configs.lexical then
			configs.lexical = {
				default_config = {
					filetypes = lexical_config.filetypes,
					cmd = lexical_config.cmd,
					root_dir = function(fname)
						return lspconfig.util.root_pattern("mix.exs", ".git")(fname) or vim.loop.os_homedir()
					end,
					-- optional settings
					settings = lexical_config.settings,
				},
			}
		end

		lspconfig.lexical.setup({
			-- optional config
			on_attach = custom_attach,
		})
	end,
})

-- keymap
local keymap = vim.api.nvim_set_keymap

local opts = { noremap = true, silent = true }
keymap("", "<Space>", "<Nop>", opts)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
keymap("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
keymap("n", "q", "<cmd>q!<cr>", opts)
