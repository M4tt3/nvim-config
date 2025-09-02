-- This will source the .vim init file
local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)
-- Require personal configs
require("matteo")
require("config.lazy")
