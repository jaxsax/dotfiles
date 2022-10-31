require'lspconfig'.rnix.setup{}

require'lspconfig'.sumneko_lua.setup{
    cmd = {"lua-language-server"},
    settings = {
        Lua = { diagnostics = { globals = {'vim'} } }
    }
}

local saga = require 'lspsaga'
saga.init_lsp_saga{}
require'lspsaga.diagnostic'.show_line_diagnostics()

-- Jump to Definition/Refrences/Implementation
vim.api.nvim_set_keymap('n', 'gd', [[<cmd>lua vim.lsp.buf.definition()<CR>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'gi', [[<cmd>lua vim.lsp.buf.implementation()<CR>]], {noremap = true, silent = true})
-- scroll down hover doc or scroll in definition preview
vim.api.nvim_set_keymap('n', '<C-f>', [[<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>]], {noremap = true, silent = true})
-- scroll up hover doc
vim.api.nvim_set_keymap('n', '<C-b>', [[<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>]], {noremap = true, silent = true})

-- Autopairs
require('nvim-autopairs').setup()

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     underline = true,
--     -- Enable virtual text, override spacing to 4
--     virtual_text = false,
--     signs = true,
--   }
-- )
