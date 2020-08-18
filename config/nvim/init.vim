if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'arcticicestudio/nord-vim'

Plug 'scrooloose/syntastic'

Plug 'rust-lang/rust.vim'
Plug 'keith/swift.vim'

call plug#end()


colorscheme nord

set number relativenumber
set nu rnu

autocmd Filetype js setlocal tabstop=2
autocmd Filetype ts setlocal tabstop=2
autocmd Filetype jsx setlocal tabstop=2
autocmd Filetype json setlocal tabstop=2

" Reloads vimrc after saving but keep cursor position
if !exists('*ReloadVimrc')
   fun! ReloadVimrc()
       let save_cursor = getcurpos()
       source $MYVIMRC
       call setpos('.', save_cursor)
   endfun
endif
autocmd! BufWritePost $MYVIMRC call ReloadVimrc()
