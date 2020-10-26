source ~/.config/nvim/plugins.vim
source ~/.config/nvim/lsp-config.vim

"*****************************************************************************
"" general
"*****************************************************************************
set autoread
" relative line numbers with current line shown as absolute number
set number relativenumber
set nu rnu

" enable hidden buffers
set hidden

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" Fix backspace indent
set backspace=indent,eol,start

set tabstop=2
set softtabstop=0
set shiftwidth=2
set expandtab

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" line wrapping
set wrap linebreak nolist
vmap <D-j> gj
vmap <D-k> gk
vmap <D-4> g$
vmap <D-6> g^
vmap <D-0> g^
nmap <D-j> gj
nmap <D-k> gk
nmap <D-4> g$
nmap <D-6> g^
nmap <D-0> g^

"" Copy/Paste/Cut
noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

set splitbelow
set splitright

"*****************************************************************************
"" appearance
"*****************************************************************************
colorscheme nord
syntax on
set cursorline
