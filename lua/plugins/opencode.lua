return {
    "sudo-tee/opencode.nvim",
    config = function()
        require("opencode").setup({
            context = {
                cursor_data = {
                      enabled = false, -- Include cursor position and line content in the context
                      context_lines = 5, -- Number of lines before and after cursor to include in context
                }
            }
        })
    end,
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "MeanderingProgrammer/render-markdown.nvim",
            opts = {
                anti_conceal = { enabled = false },
                file_types = { 'markdown', 'opencode_output' },
            },
            ft = { 'markdown', 'Avante', 'copilot-chat', 'opencode_output' },
            keys = {
                { "<leader>mm", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle Markdown Render" },
            },
        },
        -- Optional, for file mentions and commands completion, pick only one
        'saghen/blink.cmp',
        -- 'hrsh7th/nvim-cmp',

        -- Optional, for file mentions picker, pick only one
        'folke/snacks.nvim',
        -- 'nvim-telescope/telescope.nvim',
        -- 'ibhagwan/fzf-lua',
        -- 'nvim_mini/mini.nvim',
    },
}
