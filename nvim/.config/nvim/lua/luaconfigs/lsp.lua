local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  },
})

local function config(_config)
  return vim.tbl_deep_extend("force", {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }, _config or {})
end

require'lspconfig'.tsserver.setup(config())
require'lspconfig'.svelte.setup(config())
require'lspconfig'.gopls.setup(config())
-- require'lspconfig'.gopls.setup(config({
-- 	capabilties = {
-- 		textDocument = {
-- 			completion = {
-- 				completionItem = {
-- 					snippetSupport = true
-- 				}
-- 			}
-- 		}
-- 	},
-- 	init_options = {
-- 		usePlaceholders = true,
-- 		completeUnimported = true
-- 	}
-- }))

-- You need this otherwise the diagnostics doesn't clear for some reason
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
                underline = true,
                signs = false,
                update_in_insert = true
        }
)

vim.lsp.set_log_level("debug")
