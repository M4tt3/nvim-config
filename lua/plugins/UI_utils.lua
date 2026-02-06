return {
    "rcarriga/nvim-notify",
    "stevearc/dressing.nvim",
    {
        "OXY2DEV/markview.nvim",
        config = function()
            vim.keymap.set("n", "<leader>mm", "<cmd>Markview toggle<cr>", { noremap = true, silent = true })
        end
    }

}

