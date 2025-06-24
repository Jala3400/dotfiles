vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.backspace = { 'indent', 'eol', 'start' }

vim.opt.hlsearch = false
-- vim.opt.colorcolumn = '80'

vim.opt.autoread = true
vim.api.nvim_set_keymap('n', '<leader>rl', ':e<CR>', { noremap = true, silent = true })
