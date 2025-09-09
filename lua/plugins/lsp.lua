return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim', 
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/nvim-cmp',
        'j-hui/fidget.nvim'
    },
    config = function()
        -- ------------------------------ MASON SETUP ------------------------------
        local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
        lsp_capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }

        local default_setup = function(server)
            require("lspconfig")[server].setup({
                capabilities = lsp_capabilities,
            })
        end

        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = {'clangd', 'lua_ls', 'pyright'},
            handlers = {
                ["clangd"] = function()
                    require("lspconfig").clangd.setup({
                        capabilities = vim.tbl_extend("force", lsp_capabilities, {
                            offsetEncoding = { "utf-16" },
                        }),
                        cmd = { "clangd", "--background-index", "--clang-tidy", "-std=c++98", "-I/usr/include/c++/11", "-I/usr/include/x86_64-linux-gnu/c++/11" }, 
                    })
                end,
                default_setup,
            },
        })

        -- ------------------------------ MISCELLANEOUS SETUP ------------------------------

        require('fidget').setup({})

        -- ------------------------------ CMP SETUP ------------------------------
        local cmp = require'cmp'

        cmp.setup({
            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                    -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                    -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                    -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

                    -- For `mini.snippets` users:
                    -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
                    -- insert({ body = args.body }) -- Insert at cursor
                    -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
                    -- require("cmp.config").set_onetime({ sources = {} })
                end,
            },
            window = {
                -- completion = cmp.config.window.bordered(),
                -- documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                ['<C-j>'] = cmp.mapping.select_next_item(),
                ['<C-k>'] = cmp.mapping.select_prev_item()
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'vsnip' }, -- For vsnip users.
                -- { name = 'luasnip' }, -- For luasnip users.
                -- { name = 'ultisnips' }, -- For ultisnips users.
                -- { name = 'snippy' }, -- For snippy users.
            }, {
                { name = 'buffer' },
            })
        })

        -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
        -- Set configuration for specific filetype.
        --[[ cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
                { name = 'git' },
            }, {
                { name = 'buffer' },
            })
        })
        require("cmp_git").setup() ]]-- 

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            }),
            matching = { disallow_symbol_nonprefix_matching = false }
        })

        vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
        vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
        vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

        vim.api.nvim_create_autocmd('LspAttach', {
          desc = 'LSP actions',
          callback = function(event)
            local opts = {buffer = event.buf}

            -- these will be buffer-local keybindings
            -- because they only work if you have an active language server

            vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
            vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
            vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
            vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
            vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
            vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
            vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
            vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
            vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
            vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

          end
        })
    end
}
