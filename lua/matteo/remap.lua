vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") --Move lines up and down with K and J
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz") --Keep cursor at the same position when half page jumping
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "<leader>cs", "<cmd>noh<cr>") --Remap <leader>cs to clear search highlight

vim.keymap.set("n", "n", "nzzzv") -- Keep searched term in the middle of the window
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") --Move lines up and down with K and J
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz") --Keep cursor at the same position when half page jumping
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "<leader>cs", "<cmd>noh<cr>") --Remap <leader>cs to clear search highlight

vim.keymap.set("n", "n", "nzzzv") -- Keep searched term in the middle of the window
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<leader>re", "<cmd>registers<cr>")

-- Remap deletion to go to the * register

vim.keymap.set("n", "d", '"*d', { noremap = true })
vim.keymap.set("n", "D", '"*D', { noremap = true })
vim.keymap.set("n", "c", '"*c', { noremap = true })
vim.keymap.set("n", "C", '"*C', { noremap = true })
vim.keymap.set("n", "x", '"*x', { noremap = true })
vim.keymap.set("n", "X", '"*X', { noremap = true })

-- Same in visual mode
vim.keymap.set("v", "d", '"*d', { noremap = true })
vim.keymap.set("v", "c", '"*c', { noremap = true })
vim.keymap.set("v", "x", '"*x', { noremap = true })

-- Visual paste without yanking the replaced text
vim.keymap.set("x", "p", '"*dP', { noremap = true })
