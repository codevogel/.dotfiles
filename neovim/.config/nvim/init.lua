-- This config has it's roots in kickstart modular ( https://github.com/dam9000/kickstart-modular.nvim/tree/01a18a193dfa1d5837faf0df669f1b06f4301f78 )

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
require 'options'

-- [[ Basic Keymaps ]]
require 'keymaps'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'lazy-bootstrap'

-- [[ Configure and install plugins ]]
require 'lazy-plugins'

-- start server for godot pipe
local pipepath = vim.fn.stdpath 'cache' .. '/server.pipe'
if not vim.loop.fs_stat(pipepath) then
   vim.fn.serverstart(pipepath)
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
