return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter').install({ "c", "lua", "vim", "vimdoc", "python", "markdown", "markdown_inline", "html", "latex", "yaml", "cpp" , "rust"})

        vim.api.nvim_create_autocmd('FileType', {
            callback = function() 
                -- Enable treesitter highlighting and disable regex syntax
                pcall(vim.treesitter.start) 
                -- Enable treesitter-based indentation
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" 
                vim.wo.foldmethod = 'expr'
                vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            end,
        })
    end
}
