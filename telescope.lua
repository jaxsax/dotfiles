require('telescope').setup{}

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<M-f>', builtin.find_files, {})
vim.keymap.set('n', '<M-g>', builtin.live_grep, {})
