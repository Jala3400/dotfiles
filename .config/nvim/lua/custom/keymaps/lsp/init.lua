-- View line diagnostics
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = '[L]ine diagnostics' }) -- or <leader>ld

-- View all diagnostics
vim.keymap.set('n', '<leader>lD', vim.diagnostic.setloclist, { desc = '[D]iagnostics list' })

-- Go to next diagnostic
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next [d]iagnostic' })

-- Go to previous diagnostic
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous [d]iagnostic' })

-- Go to next error
vim.keymap.set('n', ']e', function()
  vim.diagnostic.goto_next { severity = vim.diagnostic.severity.ERROR }
end, { desc = 'Next [e]rror' })

-- Go to previous error
vim.keymap.set('n', '[e', function()
  vim.diagnostic.goto_prev { severity = vim.diagnostic.severity.ERROR }
end, { desc = 'Previous [e]rror' })

-- Go to next warning
vim.keymap.set('n', ']w', function()
  vim.diagnostic.goto_next { severity = vim.diagnostic.severity.WARN }
end, { desc = 'Next [w]arning' })

-- Go to previous warning
vim.keymap.set('n', '[w', function()
  vim.diagnostic.goto_prev { severity = vim.diagnostic.severity.WARN }
end, { desc = 'Previous [w]arning' })

-- Toggle diagnostics (customize as needed)
vim.keymap.set('n', '<leader>ud', function()
  vim.diagnostic.config { virtual_text = not vim.diagnostic.config().virtual_text }
end, { desc = 'Toggle [d]iagnostics' })

-- Open floating diagnostic
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Cursor [d]iagnostics' })

-- Rename symbol
map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
