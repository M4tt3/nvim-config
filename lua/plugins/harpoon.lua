function extract_filenames(items)
    local out = {}
    for i, v in ipairs(items) do
        out[i] = v.value
    end
    return out
end

function reduce_path(f, max_length)
    local components = {}
    for component in f:gmatch("([^/\\]+)") do
        table.insert(components, component)
    end

    local current_path = components[#components]
    local path_length = #current_path

    for i = #components - 1, 1, -1 do
        if path_length + 3 + #components[i] > max_length then
            current_path = "..." .. "/" .. current_path
        else
            current_path = components[i] .. "/" .. current_path
            path_length = path_length + #components[i] + 1
        end
    end

    return current_path
end

return {
    "theprimeagen/harpoon",
    branch="harpoon2",
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        -- basic telescope configuration
        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers").new({}, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table({
                    results = file_paths,
                }),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
            }):find()
        end

        vim.keymap.set("n", "<C-a>", function() harpoon:list():add() end)
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
        vim.keymap.set("n", "<leader>ph", function() toggle_telescope(harpoon:list()) end)
        vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end)
        vim.keymap.set("n", "<leader>h5", function() harpoon:list():select(5) end)
        vim.keymap.set("n", "<leader>h6", function() harpoon:list():select(6) end)
        vim.keymap.set("n", "<leader>h7", function() harpoon:list():select(7) end)
        vim.keymap.set("n", "<leader>h8", function() harpoon:list():select(8) end)
        vim.keymap.set("n", "<leader>h9", function() harpoon:list():select(9) end)
        vim.keymap.set("n", "<leader>h0", function() harpoon:list():select(10) end)		
    end
}
