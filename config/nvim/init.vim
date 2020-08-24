if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'MRBeussink/nord-vim' "use personal fork for customization
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/vim-emoji'
Plug 'neoclide/coc.nvim', {'branch': 'release' }
Plug 'tpope/vim-commentary'
" Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
" Plug 'tpope/vim-unimpaired'
Plug 'yggdroot/indentline'

Plug 'sheerun/vim-polyglot'

if isdirectory('/usr/local/opt/fzf')
	Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
endif
call plug#end()

colorscheme nord
syntax on

set number relativenumber
set nu rnu
set cursorline

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" Emoji completion
set completefunc=emoji#complete

" Enable hidden buffers
set hidden

" Fix backspace indent
set backspace=indent,eol,start

set tabstop=2
set softtabstop=0
set shiftwidth=2
set expandtab
" autocmd Filetype js setlocal tabstop=2
" autocmd Filetype ts setlocal tabstop=2
" autocmd Filetype jsx setlocal tabstop=2
" autocmd Filetype json setlocal tabstop=2


" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

set splitbelow
set splitright

"trigger fzf
nnoremap <silent> <C-p> :FZF<CR>

"" fzf.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

" The Silver Searcher
if executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
  set grepprg=ag\ --nogroup\ --nocolor
endif

" IndentLine
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = 0
" let g:indentLine_char = '⎸'
let g:indentLine_char = '┆'
" let g:indentLine_char_list = ['⎸', '¦', '┆', '¦', '┆''¦', '┆']
let g:indentLine_faster = 1

nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)

" Neat, but with thoughbot's rcm it is moot
" Reloads vimrc after saving but keep cursor position
" if !exists('*ReloadVimrc')
"    fun! ReloadVimrc()
"        let save_cursor = getcurpos()
"        source $MYVIMRC
"        call setpos('.', save_cursor)
"    endfun
" endif
" autocmd! BufWritePost $MYVIMRC call ReloadVimrc()
