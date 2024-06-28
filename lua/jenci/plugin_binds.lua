--auto Keybinding helper function
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
vim.g.mapleader = ' '
-- NERDTree
map('n', '<C-n>', ':NERDTreeToggle<CR>')  -- Toggle NERDTree

-- FZF
map('n', '<C-p>', ':Files<CR>')           -- Fuzzy find files
map('n', '<Leader>b', ':Buffers<CR>')     -- Fuzzy find buffers

-- LSP keybindings
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')       -- Go to definition
map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')      -- Go to declaration
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')       -- Find references
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')   -- Go to implementation
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')             -- Hover documentation
map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>') -- Signature help
map('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')   -- Rename symbol
map('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>') -- Code action
map('n', '<Leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>') -- Show diagnostics
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')     -- Go to previous diagnostic
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')     -- Go to next diagnostic

-- ALE
map('n', '<Leader>l', ':ALELint<CR>')                         -- Lint the current file
map('n', '<Leader>f', ':ALEFix<CR>')                          -- Fix the current file

-- Debugging with nvim-dap
map('n', '<F5>', '<cmd>lua require"dap".continue()<CR>')      -- Start/continue debugging
map('n', '<F10>', '<cmd>lua require"dap".step_over()<CR>')    -- Step over
map('n', '<F11>', '<cmd>lua require"dap".step_into()<CR>')    -- Step into
map('n', '<F12>', '<cmd>lua require"dap".step_out()<CR>')     -- Step out
map('n', '<Leader>b', '<cmd>lua require"dap".toggle_breakpoint()<CR>') -- Toggle breakpoint
map('n', '<Leader>B', '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>') -- Conditional breakpoint
map('n', '<Leader>dr', '<cmd>lua require"dap".repl.open()<CR>') -- Open REPL

-- Commentary
map('n', '<Leader>/', '<cmd>Commentary<CR>')                  -- Comment/uncomment lines

-- Additional keybindings
map('n', '<Leader>nt', ':NERDTreeToggle<CR>')                 -- Toggle NERDTree
map('n', '<Leader>ff', ':Files<CR>')                          -- Fuzzy find files
map('n', '<Leader>fb', ':Buffers<CR>')                        -- Fuzzy find buffers
map('n', '<Leader>tt', ':TSPlaygroundToggle<CR>')             -- Toggle Treesitter playground

-- General keybindings
map('n', '<Leader>w', ':w<CR>')                               -- Save file
map('n', '<Leader>q', ':q<CR>')                               -- Quit nvim
map('n', '<Leader>sv', ':source $MYVIMRC<CR>')                -- Reload config

-- Git integration with fugitive.vim
map('n', '<Leader>gs', ':Git<CR>')          -- Git status
map('n', '<Leader>gc', ':Git commit<CR>')   -- Git commit
map('n', '<Leader>gp', ':Git push<CR>')     -- Git push
map('n', '<Leader>gl', ':Gclog<CR>')        -- Git log
map('n', '<Leader>gd', ':Gdiffsplit<CR>')   -- Git diff
map('n', '<Leader>gb', ':Git blame<CR>')    -- Git blame

