-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  
  -- Essential plugins
  use 'preservim/nerdtree'                 -- File explorer
  use 'tpope/vim-fugitive'                 -- Git integration
  use { 'junegunn/fzf', run = function() fn['fzf#install']() end }
  use 'junegunn/fzf.vim'
  
  -- LSP and completion
  use 'neovim/nvim-lspconfig'              -- Collection of configurations for built-in LSP client
  use 'williamboman/mason.nvim' -- Mason for managing LSP servers
  use 'williamboman/mason-lspconfig.nvim' -- Integration between Mason and nvim-lspconfig
  use 'hrsh7th/nvim-cmp'                   -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'               -- LSP source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp -- For vsnip users
  
  -- Syntax highlighting and linting
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Debugging
  use 'mfussenegger/nvim-dap'              -- Debug Adapter Protocol

  -- Additional tools
  use 'nvie/vim-flake8'                    -- Python linting
  use 'tpope/vim-commentary'               -- Commenting
  use 'preservim/nerdcommenter'            -- Advanced commenting
  -- Tabular management
  use 'theprimeagen/harpoon'
  -- Themes
  use { "catppuccin/nvim", as = "catppuccin" }
  use {
	  'alexghergh/nvim-tmux-navigation',
	  config = function()
		  local nvim_tmux_nav = require('nvim-tmux-navigation')

		  nvim_tmux_nav.setup {
			  disable_when_zoomed = true -- defaults to false
		  }

		  vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
		  vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
		  vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
		  vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
		  vim.keymap.set('n', "<C-/>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
		  vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
	  end
  }
end)


