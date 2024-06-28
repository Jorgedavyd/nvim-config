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

