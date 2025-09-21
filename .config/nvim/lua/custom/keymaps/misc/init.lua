-- close buffers individually
vim.api.nvim_create_user_command('BdOrQuit', function()
  if #vim.fn.getbufinfo { buflisted = 1 } > 1 then
    vim.cmd 'bd'
  else
    vim.cmd 'quit'
  end
end, {})

-- basics
vim.keymap.set('n', '<C-s>', ':w<CR>', opts)
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = '[W]rtie' })
vim.keymap.set('n', '<leader>q', ':BdOrQuit<CR>', { desc = '[Q]uit' })
vim.keymap.set('n', '<leader>Q', ':q<CR>', { desc = '[Q]uit' })
vim.keymap.set('n', '<leader>e', ':Ex<CR>', { desc = '[E]xplore files' })
vim.keymap.set('n', '<leader>f', '/', { desc = 'Search' })

-- out of insert mode
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>', { desc = 'Save' })
vim.keymap.set('i', 'jk', '<Esc>', { desc = 'jk' })
vim.keymap.set('i', 'JK', '<Esc>', { desc = 'kj' })

-- nice to have
vim.keymap.set('n', '<leader>h', ':set hlsearch!<CR>', { desc = 'Toggle search highlight' })
vim.keymap.set('n', 'ñ', 'i<CR><ESC>', { desc = 'Line break here' })
vim.keymap.set('n', 'Ñ', 'a<CR><ESC>', { desc = 'Line break here' })

-- move source directory to the directory of the current file
vim.keymap.set('n', '<leader>mv', ':cd %:p:h<CR>', { desc = 'Move to file directory' })

-- move between buffers
vim.keymap.set('n', '<C-A-h>', ':BufferLineCyclePrev<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<C-A-j>', ':BufferLineCyclePrev<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<C-A-l>', ':BufferLineCycleNext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<C-A-k>', ':BufferLineCycleNext<CR>', { desc = 'Next buffer' })
