let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.vim/plugged')

" Neovim Tree shitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

Plug 'mhinz/vim-rfc'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'

Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'gruvbox-community/gruvbox'
Plug 'mhinz/vim-signify'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'natecraddock/nvim-find'

call plug#end()

" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/.git/*

set updatetime=100
set number
set ignorecase
set smartcase
set completeopt=menu,menuone,noselect

let mapleader = " "
colorscheme gruvbox
set background=dark

nnoremap <C-p> :GFiles<CR>

lua << EOF
local lsp_config = require'lspconfig'
local cmp = require'cmp'

cmp.setup({
  mapping = {
	  ['<C-d>'] = cmp.mapping.scroll_docs(-4),
	  ['<C-f>'] = cmp.mapping.scroll_docs(4),
	  ['<C-Space>'] = cmp.mapping.complete(),
	  ['<C-e>'] = cmp.mapping.close(),
	  ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local lsp_default_config = {capabilites = capabilities}
local servers = {
	tsserver = {},
	svelte = {},
        gopls = {
		cmd = {'gopls'},
                capabilties = {
                        textDocuemnt = {
                                completion = {
                                        completionItem = {
                                                snippetSupport = true
                                        }
                                }
                        }
                },
                init_options = {
                        usePlaceholders = true,
                        completeUnimported = true
                }
        }
}

for server, config in pairs(servers) do
        lsp_config[server].setup(vim.tbl_deep_extend('force', lsp_default_config, config))
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
                underline = true,
                signs = false,
                update_in_insert = true
        }
)

vim.lsp.set_log_level("debug")
EOF

lua << EOF
local cfg = require'nvim-find.config'

cfg.files.ignore = {
  "*node_modules*",
  "*.pyc",
  "bin/*"
}

EOF

nnoremap <silent> <c-f> :lua require("nvim-find.defaults").files()<cr>

autocmd BufWritePre *.go lua vim.lsp.buf.formatting()

