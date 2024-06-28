-- LSP settings
local lspconfig = require('lspconfig')

-- Configure clangd with specific filetypes
lspconfig.clangd.setup{
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
  cmd = { 'clangd', '--background-index' },
  on_attach = function(client, bufnr)
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  end
}

-- Configure pyright for Python
lspconfig.pyright.setup{}

-- Autocompletion settings
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  }
})

-- Treesitter configuration
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"python", "cpp", "c"},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

-- ALE configuration
vim.g.ale_linters = {
  python = {'flake8', 'mypy'},
  cpp = {'clang'},
}
vim.g.ale_fixers = {
  python = {'autopep8'},
  cpp = {'clang-format'},
}
vim.g.ale_python_flake8_executable = 'flake8'
vim.g.ale_python_autopep8_executable = 'autopep8'
vim.g.ale_cpp_clang_executable = 'clang'

-- Debugging setup
local dap = require('dap')
dap.adapters.python = {
  type = 'executable';
  command = os.getenv('HOME')..'/.virtualenvs/debugpy/bin/python';
  args = { '-m', 'debugpy.adapter' };
}
dap.configurations.python = {
  {
    type = 'python';
    request = 'launch';
    name = 'Launch file';
    program = "${file}";
    pythonPath = function()
      return '/usr/bin/python'
    end;
  },
}
