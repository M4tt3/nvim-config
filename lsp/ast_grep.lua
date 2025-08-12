local util = require 'lspconfig.util'

return {
  cmd = {'ast-grep', 'lsp'},
  filetypes = { -- https://ast-grep.github.io/reference/languages.html
      'c',
      'cpp',
      'rust',
      'go',
      'java',
      'python',
      'javascript',
      'typescript',
      'html',
      'css',
      'kotlin',
      'dart',
      'lua',
  },
  root_dir = util.root_pattern('sgconfig.yaml', 'sgconfig.yml')
}
