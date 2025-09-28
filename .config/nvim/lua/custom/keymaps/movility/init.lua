local opts = { noremap = true, silent = true }

-- Opening split panes
vim.keymap.set('n', '<leader>V', ':vsplit<CR>', opts)
vim.keymap.set('n', '<leader>S', ':split<CR>', opts)
vim.keymap.set('n', '<leader>T', ':tabnew<CR>', opts)

-- Navigate between splits
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Resize w arrows
vim.keymap.set('n', '<C-Up>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<C-Left>', ':vertical resize +2<CR>', opts)
vim.keymap.set('n', '<C-Right>', ':vertical resize -2<CR>', opts)
