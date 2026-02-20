return {
    "zbirenbaum/copilot.lua",
    -- dependencies = {
    --     "copilotlsp-nvim/copilot-lsp",
    --     config = function()
    --         vim.g.copilot_nes_debounce = 500
    --         vim.lsp.enable("copilot_ls")
    --     end,
    -- },
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
        require("copilot").setup({
            panel = {
                enabled = false
            },
            suggestion = {
                enabled = true,
                auto_trigger = true,
                hide_during_completion = false,
                debounce = 15,
                trigger_on_accept = true,
                keymap = {
                    accept = "<C-g>",
                    accept_word = "<C-f>",
                    accept_line = false,
                    next = "<M-]>",
                    prev = "<M-[>",
                    dismiss = "<C-]>",
                    toggle_auto_trigger = false,
                },
            },
            -- nes = {
            --     enabled = true,
            --     auto_trigger = true,
            --     keymap = {
            --         accept_and_goto = "<C-g>",
            --         accept = false,
            --         dismiss = "<Esc>",
            --     },
            -- },
        })
    end,
}
