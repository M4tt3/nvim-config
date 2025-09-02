local mason = require("mason")
local mason_lsp = require("mason-lspconfig")

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

local default_setup = function(server)
    require("lspconfig")[server].setup({
        capabilities = lsp_capabilities,
    })
end

mason.setup({})
mason_lsp.setup({
    ensure_installed = {},
    handlers = {
        ["clangd"] = function()
            require("lspconfig").clangd.setup({
                capabilities = vim.tbl_extend("force", lsp_capabilities, {
                    offsetEncoding = { "utf-16" },
                }),
                cmd = { "clangd", "--background-index", "--clang-tidy" }, 
            })
        end,
        default_setup,
    },
})
