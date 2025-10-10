return {
  "tpope/vim-surround",
  init = function()
    -- runs before plugin is sourced
    vim.g.surround_no_insert_mappings = 1
  end,
}
