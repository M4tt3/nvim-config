workspaces = require('workspaces')
require("telescope").load_extension("workspaces")

local DATA_PATH_REL = ".nvim/"
local current_ws_name = nil
local current_ws_path = nil

local function is_nvimtree_open()
    return vim.fn.bufwinnr("NvimTree_1") ~= -1
end

local function save_session(name, path, state)
    local nvim_tree_open = is_nvimtree_open()
    local session_path = path .. DATA_PATH_REL .. name .. ".vim"
    if nvim_tree_open then
        vim.api.nvim_command("NvimTreeClose") -- Close NvimTree to avoid issues with session saving
    end
    vim.fn.mkdir(DATA_PATH_REL, "p")
    vim.api.nvim_command("mksession! " .. session_path) 
    if nvim_tree_open then
        vim.api.nvim_command("NvimTreeOpen") -- Reopen NvimTree after saving session
    end
    return true
end

local function load_session(name, path, state)
    local session_path = path .. DATA_PATH_REL .. name .. ".vim"
    if vim.fn.filereadable(session_path) == 1 then
        vim.api.nvim_command("source "  .. session_path)
        current_ws_name = name
        current_ws_path = path
        return true
    else
        print("No session file found at " .. session_path)
        return false
    end 
end

local function save_session_if_open()
    if current_ws_name ~= nil and current_ws_path ~= nil then
        save_session(current_ws_name, current_ws_path, {})
    end
end

vim.api.nvim_create_autocmd("WinEnter", {
    pattern = "*",
    callback = save_session_if_open,
})

vim.keymap.set("n", "<leader>ss", save_session_if_open, { desc = "Save current workspace session" })

vim.keymap.set("n", "<leader>ws", function()
    require("telescope").extensions.workspaces.workspaces()
end, { desc = "Workspaces picker" })

workspaces.setup{
    -- path to a file to store workspaces data in
    -- on a unix system this would be ~/.local/share/nvim/workspaces
    path = vim.fn.stdpath("data") .. "/workspaces",

    -- to change directory for nvim (:cd), or only for window (:lcd)
    -- deprecated, use cd_type instead
    -- global_cd = true,

    -- controls how the directory is changed. valid options are "global", "local", and "tab"
    --   "global" changes directory for the neovim process. same as the :cd command
    --   "local" changes directory for the current window. same as the :lcd command
    --   "tab" changes directory for the current tab. same as the :tcd command
    --
    -- if set, overrides the value of global_cd
    cd_type = "global",

    -- sort the list of workspaces by name after loading from the workspaces path.
    sort = true,

    -- sort by recent use rather than by name. requires sort to be true
    mru_sort = true,

    -- option to automatically activate workspace when opening neovim in a workspace directory
    auto_open = false,

    -- option to automatically activate workspace when changing directory not via this plugin
    -- set to "autochdir" to enable auto_dir when using :e and vim.opt.autochdir
    -- valid options are false, true, and "autochdir"
    auto_dir = false,

    -- enable info-level notifications after adding or removing a workspace
    notify_info = true,

    -- lists of hooks to run after specific actions
    -- hooks can be a lua function or a vim command (string)
    -- lua hooks take a name, a path, and an optional state table
    -- if only one hook is needed, the list may be omitted
    hooks = {
        open_pre = {},
        open = {
            load_session,
            "NvimTreeOpen",
        },
        add = {
            save_session
        },
        remove = {},
        rename = {},
    },
}
