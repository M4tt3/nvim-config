return {
    'Exafunction/windsurf.vim',
    event = 'BufEnter',
    config = function()
        vim.g.codeium_disable_bindings = 1

        vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
        vim.keymap.set('i', '<C-f>', function() return vim.fn['codeium#AcceptNextWord']() end, { expr = true, silent = true })
        vim.keymap.set('i', '<C-l>', function() return vim.fn['codeium#AcceptNextLine']() end, { expr = true, silent = true })
    end
}

