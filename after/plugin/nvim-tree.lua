tree = require("nvim-tree")

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

tree.setup({
    view = {
        width = 30,
        side = "left",
    },
    renderer = {
        highlight_git = true,
        highlight_opened_files = "all",
        indent_markers = {
            enable = true,
        },
    },
    filters = {
        dotfiles = false,
    },
})
