return {
    'brenton-leighton/multiple-cursors.nvim',
    config = function()
        m_cursors = require("multiple-cursors")
        m_cursors.setup({})

        local map = vim.keymap.set
        map({"n", "x"},      "<C-j>",         "<Cmd>MultipleCursorsAddDown<CR>")
        map({"n", "x"},      "<C-k>",         "<Cmd>MultipleCursorsAddUp<CR>")
        map({"n", "i", "x"}, "<C-Up>",        "<Cmd>MultipleCursorsAddUp<CR>")
        map({"n", "i", "x"}, "<C-Down>",      "<Cmd>MultipleCursorsAddDown<CR>")
        map({"n", "i"},      "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>")
        map({"x"},           "<Leader>m",     "<Cmd>MultipleCursorsAddVisualArea<CR>")
        map({"n", "x"},      "<Leader>a",     "<Cmd>MultipleCursorsAddMatches<CR>")
        map({"n", "x"},      "<Leader>A",     "<Cmd>MultipleCursorsAddMatchesV<CR>")
        map({"n", "x"},      "<Leader>d",     "<Cmd>MultipleCursorsAddJumpNextMatch<CR>")
        map({"n", "x"},      "<Leader>D",     "<Cmd>MultipleCursorsJumpNextMatch<CR>")
        map({"n", "x"},      "<Leader>l",     "<Cmd>MultipleCursorsLock<CR>")
        map({"n"},           "<Leader>|",     function() m_cursors.align() end)
    end
}
