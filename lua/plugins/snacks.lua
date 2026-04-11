return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        explorer = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        notifier = {
            enabled = true,
            timeout = 3000,
        },
        image = { enabled = true },
        picker = {
            enabled = true,
            sources = {
                harpoon = {
                    finder = function(opts, ctx)
                        local harpoon = require("harpoon"):list()
                        local files = {}
                        local cwd = vim.loop.cwd()
                        for idx, item in pairs(harpoon.items) do
                            table.insert(files,
                                {
                                    cwd = cwd,
                                    text = item.value,
                                    file = item.value,
                                    idx = idx
                                }
                            )
                        end

                        table.sort(files, function(a, b)
                            return a.idx < b.idx
                        end)

                        return files
                    end,
                    format = "text",
                    preview = "file",
                    confirm = "jump",
                    win = {
                        input = {
                            keys = {
                                ["<C-d>"] = "harpoon_delete",
                            }
                        }
                    },
                    actions = {
                        harpoon_delete = function(picker, item)
                            local to_remove = item or picker:selected()
                            print("Removing from Harpoon:", to_remove.idx)
                            local list = require("harpoon"):list()
                            for _, it in ipairs(list.items) do
                                if it.value == item.file then
                                    list:remove(it)
                                    break
                                end
                            end

                            picker:refresh()
                        end
                    },
                }
            }
        },
        quickfile = { enabled = true },
        scope = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        styles = {
            notification = {
                -- wo = { wrap = true } -- Wrap notifications
            }
        }
    },
    keys = {
        -- Top Pickers & Explorer
        { "<leader>pf", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
        { "<leader>ps", function() Snacks.picker.grep() end, desc = "Grep" },
        { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
        { "<leader>pn", function() Snacks.picker.notifications() end, desc = "Notification History" },
        { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
        { "<leader>ph", function() Snacks.picker.harpoon() end, desc = "Harpoon Files" },
        -- find
        { "<leader>pcc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
        { "<leader>pv", function() Snacks.picker.files() end, desc = "Find Files" },
        { "<leader>pr", function() Snacks.picker.recent() end, desc = "Recent" },
        -- git
        { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
        { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
        { "<leader>glf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
        { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
        { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
        -- Grep
        { "<leader>/", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
        { "<leader>*", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
        -- search
        { '<leader>re', function() Snacks.picker.registers() end, desc = "Registers" },
        { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
        { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
        -- LSP
        -- { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
        -- { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
        -- { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
        -- { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
        -- { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
        -- { "gai", function() Snacks.picker.lsp_incoming_calls() end, desc = "C[a]lls Incoming" },
        -- { "gao", function() Snacks.picker.lsp_outgoing_calls() end, desc = "C[a]lls Outgoing" },
        -- { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
        -- { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
        -- Other
    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end

                -- Override print to use snacks for `:=` command
                if vim.fn.has("nvim-0.11") == 1 then
                    vim._print = function(_, ...)
                        dd(...)
                    end
                else
                    vim.print = _G.dd 
                end

                -- Create some toggle mappings
                Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                Snacks.toggle.diagnostics():map("<leader>ud")
            end,
        })
    end,
}
