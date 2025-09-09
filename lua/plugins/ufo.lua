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
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "VeryLazy",
    config = function()
        local handler = function(virtText, lnum, endLnum, width, truncate)
            local newVirtText = {}
            local foldedLines = endLnum - lnum
            local suffix = (" 󰁂 %d"):format(foldedLines)

            local sufWidth = vim.fn.strdisplaywidth(suffix)
            local targetWidth = width - sufWidth
            local curWidth = 0
            for _, chunk in ipairs(virtText) do
                local chunkText = chunk[1]
                local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                if targetWidth > curWidth + chunkWidth then
                    table.insert(newVirtText, chunk)
                else
                    chunkText = truncate(chunkText, targetWidth - curWidth)
                    local hlGroup = chunk[2]
                    table.insert(newVirtText, { chunkText, hlGroup })
                    chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if curWidth + chunkWidth < targetWidth then
                        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                    end
                    break
                end
                curWidth = curWidth + chunkWidth
            end
            local rAlignAppndx = math.max(math.min(vim.opt.textwidth["_value"], width - 1) - curWidth - sufWidth, 0)
            suffix = (" "):rep(rAlignAppndx) .. suffix
            table.insert(newVirtText, { suffix, "MoreMsg" })
            return newVirtText
        end
        require("ufo").setup({
            fold_virt_text_handler = handler,
            open_fold_hl_timeout = 400,
            preview = {
                win_config = {
                    border = { "", "─", "", "", "", "─", "", "" },
                    winblend = 0,
                },
                mappings = {
                    scrollU = "<C-u>",
                    scrollD = "<C-d>",
                    jumpTop = "[",
                    jumpBot = "]",
                },
            },
        })

        vim.o.fillchars = [[eob: ,fold: ,foldopen:󰅀,foldsep: ,foldclose:󰅂]]
        vim.o.foldcolumn = "auto:9" -- 10 breaks the plugin, 9 works with the issue mentioned before
        vim.o.foldnestmax = 1
        vim.o.foldlevel = 99999999 -- Bigger than this also breaks the plugin
        vim.o.foldlevelstart = 99999999
        vim.o.foldenable = true

        vim.o.scrolloff = 5
        vim.o.sidescrolloff = 5

        -- Redrawing and cursor enhancements

        vim.fn.sign_define("FoldClosed", { text = "󰅂", texthl = "Folded" })
        vim.fn.sign_define("FoldOpen", { text = "󰅀", texthl = "Folded" })
        vim.fn.sign_define("FoldSeparator", { text = " ", texthl = "Folded" })

        vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
        vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
        vim.keymap.set('n', 'zr', ":foldopen<cr>")
        vim.keymap.set('n', 'zm', ":foldclose<cr>")
    end,
}
