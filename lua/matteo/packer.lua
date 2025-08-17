
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use { 
        "catppuccin/nvim", 
        as = "catppuccin", 
        config = function()
            vim.cmd.colorscheme("catppuccin-macchiato") 
        end
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

    use ('mason-org/mason.nvim')
    use {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        }
    }

    use ('nvim-treesitter/playground') 
    use ('theprimeagen/harpoon')
    use ('theprimeagen/vim-be-good')
    use ('mbbill/undotree')
    use ('tpope/vim-fugitive')
    use ('brenton-leighton/multiple-cursors.nvim')
    use ('nvim-tree/nvim-tree.lua')
    use ('nvim-tree/nvim-web-devicons')
    use ('natecraddock/workspaces.nvim')

    --nvim cmp setup
    use('neovim/nvim-lspconfig')
    use('hrsh7th/cmp-nvim-lsp')
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-path')
    use('hrsh7th/cmp-cmdline')
    use('hrsh7th/nvim-cmp')

    -- For vsnip users.
    -- use('hrsh7th/cmp-vsnip')
    -- use('hrsh7th/vim-vsnip')


end)
