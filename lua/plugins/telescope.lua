return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require("telescope").setup{
            defaults = {
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--hidden",
                    "--no-ignore-vcs",  -- <--- makes rg ignore .gitignore
                }
            },
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
            },
            extensions = {
                workspaces = {
                    -- keep insert mode after selection in the picker, default is false
                    keep_insert = true,
                    -- Highlight group used for the path in the picker, default is "String"
                    path_hl = "String"
                }
            }
        }
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<leader>pg', builtin.git_files, {})
        vim.keymap.set('n', '<leader>pd', function()
            builtin.find_files({
                cwd = vim.fn.expand("%:p:h"),
            })
        end)
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
    end
}
