" auto install vim-plug
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
" lsp
Plug 'neovim/nvim-lsp'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/diagnostic-nvim'
" Plug 'dense-analysis/ale'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete-lsp'

" javascript
Plug 'prettier/vim-prettier'

" appearance
Plug 'arcticicestudio/nord-vim'
Plug 'airblade/vim-gitgutter'
Plug 'yggdroot/indentline'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" utility
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'pseewald/vim-anyfold'
if isdirectory('/usr/local/opt/fzf')
	Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
endif
call plug#end()

" todo
" Plug 'junegunn/vim-emoji'
" Plug 'tpope/vim-fugitive'
" Plug 'voldikss/vim-floaterm' " appears to have good integration with lf and
" other terminal file browsers

"*****************************************************************************
"" apperance
"*****************************************************************************

colorscheme nord

" IndentLine
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = 0
" ['⎸', '¦', '┆', '¦', '┆''¦', '┆']
let g:indentLine_char_list = ['⎸', '¦']
let g:indentLine_faster = 1

"*****************************************************************************
"" javascript
"*****************************************************************************

" Set it up so that Prettier runs on save for .js .jsx and .ts files
" augroup AutomaticPrettier
"   autocmd!
"   autocmd BufWritePre,FileWritePre,FileAppendPre *.js :Prettier
"   autocmd BufWritePre,FileWritePre,FileAppendPre *.jsx :Prettier
"   autocmd BufWritePre,FileWritePre,FileAppendPre *.ts :Prettier
" augroup END

"*****************************************************************************
"" utility
"*****************************************************************************

" vim-anyfold
augroup Anyfold
  autocmd Filetype * AnyFoldActivate
augroup END
autocmd Anyfold Filetype AnyFoldActivate
set foldlevel=1
filetype plugin indent on

" fzf.vim
nnoremap <silent> <C-p> :FZF<CR>
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
" fzf - The Silver Searcher
if executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
  set grepprg=ag\ --nogroup\ --nocolor
endif

"vim-vinegar
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'


