return {
  "tpope/vim-surround",
  init = function()
    -- runs before plugin is sourced
    vim.g.surround_no_insert_mappings = 1
  end,
  config = function()
    -- runs after plugin is loaded
    vim.keymap.set("i", "<C-s>", "<Plug>Isurround")
  end,
}
