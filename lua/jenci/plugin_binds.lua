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

--- Debugging with nvim-dap
map('n', '<F5>', '<cmd>lua require"dap".continue()<CR>')      -- Start/continue debugging
map('n', '<F10>', '<cmd>lua require"dap".step_over()<CR>')    -- Step over
map('n', '<F11>', '<cmd>lua require"dap".step_into()<CR>')    -- Step into
map('n', '<F12>', '<cmd>lua require"dap".step_out()<CR>')     -- Step out
map('n', '<Leader>b', '<cmd>lua require"dap".toggle_breakpoint()<CR>') -- Toggle breakpoint
map('n', '<Leader>B', '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>') -- Conditional breakpoint
map('n', '<Leader>dr', '<cmd>lua require"dap".repl.open()<CR>') -- Open REPL

-- Commentary
map('n', '<Leader>/', '<cmd>Commentary<CR>')                  -- Comment/uncomment lines

-- General keybindings
map('n', '<Leader>w', ':w<CR>')                               -- Save file
map('n', '<Leader>q', ':q<CR>')                               -- Quit nvim

-- Git integration with fugitive.vim
map('n', '<Leader>gs', ':Git<CR>')          -- Git status
map('n', '<Leader>gc', ':Git commit<CR>')   -- Git commit
map('n', '<Leader>gp', ':Git push<CR>')     -- Git push
map('n', '<Leader>gl', ':Gclog<CR>')        -- Git log
map('n', '<Leader>gd', ':Gdiffsplit<CR>')   -- Git diff
map('n', '<Leader>gb', ':Git blame<CR>')    -- Git blame
map('n', '<Leader>gP', ':Git pull<CR>')     -- Git pull
