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

