local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input(" Grep > ") })
end)

require("telescope").setup{
    pickers = {
        find_files = {
            find_command = {
                "rg",
                "--files",
                "--hidden",
                "--no-ignore-vcs",
                "-g",
                "!**/.git/*",
                "-g",
                "!**/node_modules/*",
                "-g", "!**/.repro/*", -- just to hide .repro rtp
            }
        }
    }
}
