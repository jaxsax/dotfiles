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
Plug 'windwp/nvim-autopairs'

Plug 'mhinz/vim-rfc'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'

Plug 'Shougo/context_filetype.vim'
Plug 'sbdchd/neoformat'

Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'gruvbox-community/gruvbox'
Plug 'mhinz/vim-signify'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

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
set signcolumn=yes
set hidden
set noswapfile
set nobackup
set termguicolors
set colorcolumn=120
set incsearch
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab

let mapleader = " "
let g:signify_realtime = 1
colorscheme gruvbox
set background=dark

nnoremap <silent> <c-p> :lua require('luaconfigs.telescope').project_files()<cr>
nnoremap <silent> <c-g> :lua require('telescope.builtin').live_grep()<cr>

lua require("luaconfigs")
lua require'nvim-treesitter.configs'.setup { indent = { enable = true }, highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}

augroup fmt
    autocmd!
    autocmd BufWritePre *.lua,*.css,*.html,*.js,*.json undojoin | Neoformat
    autocmd BufWritePre *.svelte,*.ts lua vim.lsp.buf.formatting()
    autocmd BufWritePre * %s/\s\+$//e
augroup END

" https://github.com/neovim/nvim-lspconfig/issues/115
lua <<EOF
    function org_imports(wait_ms)
      local params = vim.lsp.util.make_range_params()
      params.context = {only = {"source.organizeImports"}}
      local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
      for _, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
          if r.edit then
            vim.lsp.util.apply_workspace_edit(r.edit)
          else
            vim.lsp.buf.execute_command(r.command)
          end
        end
      end
  end
EOF

augroup GO_LSP
	autocmd!
	autocmd BufWritePre *.go :silent! lua vim.lsp.buf.formatting()
	autocmd BufWritePre *.go :silent! lua org_imports(3000)
augroup END
