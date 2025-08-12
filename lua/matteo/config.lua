-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Wrap text longer than window to newline
vim.opt.wrap = false

-- Tabs options
vim.opt.expandtab = true     -- Use spaces 
vim.opt.tabstop = 4          -- Display width of a tab
vim.opt.shiftwidth = 4       -- Indent width
vim.opt.softtabstop = 4      -- Spaces per Tab in insert mode

-- Default yanking register to system clipboard (+)
vim.opt.clipboard = 'unnamedplus'
