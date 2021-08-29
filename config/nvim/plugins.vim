" auto install vim-plug
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
  autocmd!
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
" Plug 'nvim-lua/diagnostic-nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" javascript
Plug 'prettier/vim-prettier'

"appearance
" Plug 'arcticicestudio/nord-vim' " there's an unmerged PR for adding treesitter support
Plug 'shaunsingh/nord.nvim' " port of nord vim with added support
" Plug 'ChristianChiarulli/nvcode-color-schemes.vim' " has tree-sitter support for Nord
Plug 'gruvbox-community/gruvbox'
Plug 'airblade/vim-gitgutter'
Plug 'yggdroot/indentline'
Plug 'nathanaelkane/vim-indent-guides'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'hoob3rt/lualine.nvim'
Plug 'shadmansaleh/lualine.nvim' " fork with bug fixes
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-lua/plenary.nvim' " needed to fix a bug in lualine


" utility
Plug 'machakann/vim-sandwich'
Plug 'mhinz/vim-startify'
" Plug 'pseewald/vim-anyfold'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'unblevable/quick-scope'
if isdirectory('/usr/local/opt/fzf')
	Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
  Plug 'jremmen/vim-ripgrep'
  Plug 'stsewd/fzf-checkout.vim'
  " Plug 'chengzeyi/fzf-preview.vim'
endif
call plug#end()

" etc
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

" todo
" Plug 'junegunn/vim-emoji'
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

lua <<EOF
require("plenary.reload").reload_module("lualine", true)
require'lualine'.setup {
  options = {
    theme = 'nord',
  },
}
EOF

"*****************************************************************************
"" javascript
"*****************************************************************************

" Set it up so that Prettier runs on save for .js .jsx and .ts files
" Bug causes remander of file being linted to delete and save
" augroup AutomaticPrettier
"   autocmd!
"   autocmd BufWritePre,FileWritePre,FileAppendPre *.js :Prettier
"   autocmd BufWritePre,FileWritePre,FileAppendPre *.jsx :Prettier
"   autocmd BufWritePre,FileWritePre,FileAppendPre *.ts :Prettier
" augroup END

"*****************************************************************************
"" utility
"*****************************************************************************

" fugitive
noremap <leader>gs :G<CR>
noremap <leader>gj :diffget //3<CR> " select right side of merge
noremap <leader>gf :diffget //2<CR> " select left side of merge
noremap <leader>gc :GCheckout<CR>

" vim-anyfold
" augroup Anyfold
"   autocmd!
"   autocmd Filetype * AnyFoldActivate
" augroup END
" autocmd Anyfold Filetype AnyFoldActivate
" set foldlevel=1
" filetype plugin indent on

augroup remember_folds
  autocmd!
  au BufWinLeave ?* mkview 1
  au BufWinEnter ?* silent! loadview 1
augroup END

" fzf.vim
nnoremap <silent> <C-p> :FZF<CR>
" nnoremap <silent> <Leader>f :Rg<CR>
set wildmode=list:longest,list:full

set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
" Shoutout to this nice blog post:
" https://www.erickpatrick.net/blog/adding-syntax-highlighting-to-fzf.vim-preview-window
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
" let $FZF_DEFAULT_COMMAND = "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
let $FZF_DEFAULT_COMMAND = 'rg --files --ignore-case --hidden -g "!{.git,node_modules,vendor}/*"'
command! -bang -nargs=? -complete=dir Files
     \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4 --preview 'bat --color=always --style=header,grid --line-range :300 {}'"
" fzf - The Silver Searcher
" if executable('ag')
"   let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
"   set grepprg=ag\ --nogroup\ --nocolor
" endif

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

"vim-vinegar
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

" treesitter
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
" Enable it all
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "javascript", "typescript", "dockerfile", "rust", "json", "lua" },
  highlight = {
    enable = true,
  },
  refactor = {
    -- Highlighting definitions doesn't seem to work inside JS the way I'd expect. :thinking:
    highlight_definitions = { enable = true },
    -- highlight_current_scope = { enable = true },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "<leader>r",
      },
    },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = "<leader>dd",
        list_definitions = "<leader>dl",
        goto_next_usage = "<a-j>",
        goto_previous_usage = "<a-k>",
      },
    },
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        -- Not really useful on how we use JS
        -- ["ac"] = "@class.outer",
        -- ["ic"] = "@class.inner",
      },
    },
  },
}
EOF
