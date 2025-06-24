-- Comment toggle (requires a comment plugin like Comment.nvim)
local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<C-ç>', 'gcc', opts)

-- Move lines up and down
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', opts)
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', opts)
vim.keymap.set('x', '<A-j>', ":m '>+1<CR>gv=gv", opts)
vim.keymap.set('x', '<A-k>', ":m '<-2<CR>gv=gv", opts)

vim.keymap.set('n', '<A-Down>', ':m .+1<CR>==', opts)
vim.keymap.set('n', '<A-Up>', ':m .-2<CR>==', opts)
vim.keymap.set('x', '<A-Down>', ":m '>+1<CR>gv=gv", opts)
vim.keymap.set('x', '<A-Up>', ":m '<-2<CR>gv=gv", opts)

-- Duplicate lines up and down
-- Duplicate line with Alt+Shift+Arrow keys and HJKL
local function duplicate_line(direction)
  local line = vim.fn.line '.'
  local col = vim.fn.col '.'
  vim.cmd 'normal! yyp'
  if direction == 'up' then
    vim.cmd 'normal! k'
  end
  vim.fn.cursor(line, col)
end

-- Alt+Shift+Arrow keys
vim.keymap.set('n', '<A-S-Up>', function()
  duplicate_line 'up'
end, { desc = 'Duplicate line up' })
vim.keymap.set('n', '<A-S-Down>', function()
  duplicate_line 'down'
end, { desc = 'Duplicate line down' })

-- Alt+Shift+HJKL
vim.keymap.set('n', '<A-S-K>', function()
  duplicate_line 'up'
end, { desc = 'Duplicate line up' })
vim.keymap.set('n', '<A-S-J>', function()
  duplicate_line 'down'
end, { desc = 'Duplicate line down' })

-- Use Shift-Tab to go backwards in completion menu
vim.keymap.set('i', '<S-Tab>', function()
  if vim.fn.pumvisible() == 1 then
    return '<C-p>'
  else
    return '<S-Tab>'
  end
end, { expr = true, noremap = true })

vim.keymap.set('n', '<C-S-t>', ':e #<CR>', { desc = 'Reopen last closed tab' })

-- Change buffer
vim.keymap.set('n', 'gt', ':bnext<CR>', opts)
vim.keymap.set('n', 'gT', ':bprevious<CR>', opts)
