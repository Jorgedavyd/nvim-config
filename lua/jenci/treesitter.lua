require'nvim-treesitter.configs'.setup {
  ensure_installed = {"python", "cpp", "c", "markdown", "markdown_inline"},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

