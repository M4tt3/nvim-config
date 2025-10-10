-- return {
--     'Exafunction/windsurf.vim',
--     event = 'BufEnter',
--     config = function()
--         vim.g.codeium_disable_bindings = 1
--
--         vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
--         vim.keymap.set('i', '<C-f>', function() return vim.fn['codeium#AcceptNextWord']() end, { expr = true, silent = true })
--         vim.keymap.set('i', '<C-l>', function() return vim.fn['codeium#AcceptNextLine']() end, { expr = true, silent = true })
--     end
-- }

local function SuggestOneWord()
    local suggestion = vim.fn['copilot#Accept']("")
    local bar = vim.fn['copilot#TextQueuedForInsertion']()
    return vim.fn.split(bar,  [[[ .]\zs]])[1]
end

return {
    'github/copilot.vim',
    config = function()
        vim.g.copilot_no_tab_map = true

        vim.keymap.set('i', '<C-g>', vim.fn['copilot#Accept'], { expr = true, silent = true, noremap = true, replace_keycodes = false})
        vim.keymap.set('i', '<C-f>', SuggestOneWord, {expr = true, remap = false})
    end
}



