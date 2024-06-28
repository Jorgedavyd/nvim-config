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
  use 'hrsh7th/nvim-cmp'                   -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'               -- LSP source for nvim-cmp
  use 'hrsh7th/cmp-buffer'                 -- Buffer source for nvim-cmp
  use 'hrsh7th/cmp-path'                   -- Path source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip'           -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip'                   -- Snippets plugin

  -- Syntax highlighting and linting
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'dense-analysis/ale'                 -- Asynchronous linting

  -- Debugging
  use 'mfussenegger/nvim-dap'              -- Debug Adapter Protocol

  -- Additional tools
  use 'nvie/vim-flake8'                    -- Python linting
  use 'tpope/vim-commentary'               -- Commenting
  use 'preservim/nerdcommenter'            -- Advanced commenting

  -- Themes
  use 'theprimeagen/harpoon'
  use { "catppuccin/nvim", as = "catppuccin" }
end)
