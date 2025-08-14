local mason = require("mason")
local mason_lsp = require("mason-lspconfig")

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local default_setup = function(server)
  require('lspconfig')[server].setup({
    capabilities = lsp_capabilities,
  })
end

mason.setup({})
mason_lsp.setup({
  ensure_installed = {},
  handlers = {
    default_setup,
  },
})

