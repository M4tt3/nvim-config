return {
    "tpope/vim-fugitive",
    config = function() 
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
        vim.keymap.set("n", "<leader>g<Left>", "<cmd>diffget //2<CR>")
        vim.keymap.set("n", "<leader>g<Right>", "<cmd>diffget //3<CR>")
        vim.keymap.set("n", "<leader>gc", ':Git commit -m ""<Left>')
        vim.keymap.set("n", "<leader>gm", "<cmd>Gvdiffsplit!<CR>")

        vim.api.nvim_create_user_command("LocalDiffget", function()
          vim.cmd("diffget //2")
        end, {})

        vim.api.nvim_create_user_command("RemoteDiffget", function()
          vim.cmd("diffget //3")
        end, {})

    end
}
