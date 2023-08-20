vim.cmd "set number"
vim.cmd "syntax on"
vim.cmd "set tabstop=4"
vim.cmd "set shiftwidth=4"
vim.cmd "set expandtab"
vim.cmd "set termguicolors"
vim.cmd "set background=dark"
vim.cmd "let g:grubbox_material_background = 'hard'"
vim.cmd "let g:grubbox_material_foreground = 'original'"
vim.cmd "let g:gruvbox_material_better_performance = 1"
vim.cmd "colorscheme moonfly"
vim.cmd "let g:lightline = { 'colorscheme': 'moonfly' }"

require('plugins')
require('keymaps')

vim.cmd "cd %:h"
